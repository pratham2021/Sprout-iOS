//  SearchView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/25.

import SwiftUI

struct SearchView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var plantsSpecies: [Plant]
    @State var speciesCareGuides: [Plant]
    @State var pestDiseases: [Plant]
    
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            if plantsSpecies.count != 0 {
                Color.red.ignoresSafeArea()
            }
            
            List {
                Section(header: Text("Plant Species").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<10, id: \.self) { index in
                                VStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(cardBackgroundColor)
                                        .frame(width: 120, height: 80)
                        
                                    Text("Species \(index + 1)")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .frame(width: 120)
                                .shadow(radius: 2)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                
                Section(header: Text("Species Care Guide").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<10, id: \.self) { index in
                                VStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(cardBackgroundColor)
                                        .frame(width: 120, height: 80)
                                    Text("Species Care Guide \(index + 1)")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .frame(width: 120)
                                .shadow(radius: 2)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                
                Section(header: Text("Pest Disease").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<10, id: \.self) { index in
                                VStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(cardBackgroundColor)
                                        .frame(width: 120, height: 80)
                                    Text("Pest Disease \(index + 1)")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .frame(width: 120)
                                .shadow(radius: 2)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .listStyle(.insetGrouped)
        }
        .onAppear {
            Task {
                var speciesOfPlant = [Plant]()
                
                await fetchSpecies { plants in
                    speciesOfPlant = plants
                }
                
                print(speciesOfPlant.count)
                
                
                await MainActor.run {
                    plantsSpecies = speciesOfPlant
                }
            }
        }
    }
    
    private var cardBackgroundColor: Color {
        colorScheme == .light
        ? Color(red: 250/255, green: 187/255, blue: 139/255)
        : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 250/255, green: 187/255, blue: 139/255)
            : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .black : .black.opacity(0.8)
    }
    
    private var headerColor: Color {
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

#Preview {
    SearchView(plantsSpecies: [Plant](), speciesCareGuides: [Plant](), pestDiseases: [Plant]()).preferredColorScheme(.light)
}
