//  SavedView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/2025

import SwiftUI

struct SavedView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var plants = ["Pratham", "Hebbar", "Arjun", "Elizabeth"]
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: textColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                if plants.isEmpty {
                    Text("No saved plants.").foregroundColor(textColor)
                }
                else {
                    List {
                        SavedPlantCardView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowInsets(EdgeInsets())
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .listStyle(.insetGrouped)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Your Plants")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(textColor)
                }
            }
            .onAppear {
                updateNavigationBarColor()
            }
            .onChange(of: colorScheme) { _, newColorScheme in
                updateNavigationBarColor()
            }
        }
    }
    
    private func updateNavigationBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        
        appearance.backgroundColor = colorScheme == .dark
            ? UIColor(red: 250/255, green: 187/255, blue: 139/255, alpha: 1)
            : UIColor(red: 244/255, green: 218/255, blue: 198/255, alpha: 1)
        
        appearance.titleTextAttributes = [.foregroundColor: textColor]
        appearance.titleTextAttributes = [.foregroundColor: textColor]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
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

#Preview {
    SavedView().preferredColorScheme(.light)
}
