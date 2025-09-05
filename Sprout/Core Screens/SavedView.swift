//  SavedView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/2025

import SwiftUI
import SwiftData

struct SavedView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @Query(sort: \LocalPlant.dateSaved) var localPlants: [LocalPlant]
    @EnvironmentObject var remotePlantViewModel: RemotePlantViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            List {
                if !remotePlantViewModel.remotePlants.isEmpty {
                    ForEach(remotePlantViewModel.remotePlants) { firebasePlant in
                        remotePlantRow(for: firebasePlant)
                    }
                }
                else if !localPlants.isEmpty {
                    ForEach(localPlants) { localPlant in
                        plantRow(for: localPlant)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .listStyle(.plain)
            .environment(\.editMode, .constant(.inactive))
            .overlay {
                if localPlants.isEmpty {
                    emptyStateView
                }
            }
        }
        .task {
            let userID = viewModel.currentUser?.id
            
            if userID != nil && userID! != "" {
                remotePlantViewModel.getData(userID: userID!)
            }
        }
    }
    
    @ViewBuilder
    private func remotePlantRow(for remotePlant: RemotePlant) -> some View {
        RemoteSavedPlantCardView(savedPlant: remotePlant)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 8)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                // Code to delete plant off the database
                
            }
    }
    
    @ViewBuilder
    private func plantRow(for localPlant: LocalPlant) -> some View {
        SavedPlantCardView(savedPlant: localPlant)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 8)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                deleteButton(for: localPlant)
            }
    }
    
    @ViewBuilder
    private func deleteButton(for localPlant: LocalPlant) -> some View {
        Button(role: .destructive) {
            context.delete(localPlant)
            do {
                try context.save()
            } catch {
                print("Failed to delete plant: \(error)")
            }
        } label: {
            Image(systemName: "trash.fill")
        }
    }
    
    @ViewBuilder
    private var emptyStateView: some View {
        ContentUnavailableView(label: {
            Label {
                Text("No Saved Plants")
                    .foregroundColor(textColor)
            } icon: {
                Image(systemName: "apple.meditate")
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(textColor)
            }
        }, description: {
            Text("Start saving plants to your account to see your list.")
                .foregroundColor(textColor)
        }, actions: {
            
        })
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 250/255, green: 187/255, blue: 139/255)
            : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

//#Preview {
//    SavedView().preferredColorScheme(.light)
//}
