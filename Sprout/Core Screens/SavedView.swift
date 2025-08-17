//  SavedView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/2025

import SwiftUI

struct SavedView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var plants:[String] = ["P", "A", "R"]
    
    var body: some View {
        
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
