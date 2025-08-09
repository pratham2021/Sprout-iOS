//  SearchView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/25.

import SwiftUI

struct SearchView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            Text("Search and look through a collection of plants").foregroundColor(textColor)
        }
        .task {
            await fetchVegetables()
        }
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 250/255, green: 187/255, blue: 139/255)
            : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .black : .black.opacity(0.8)
    }
}

#Preview {
    SearchView().preferredColorScheme(.light)
}
