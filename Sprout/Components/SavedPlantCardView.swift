//
//  SavedPlantCardView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/13/25.
//

import SwiftUI

struct SavedPlantCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(cardBackgroundColor)
                .opacity(0.8)
                .cornerRadius(15)
            
            VStack(spacing: 10) {
                Text("European Silver Fir")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: true, vertical: true)
                    .foregroundColor(textColor)
                
                Image("golden-pothos")
                    
                Text("Saved on Aug 13, 2025")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: true, vertical: true)
                    .foregroundColor(textColor)
            }
            .padding(8)
        }
        .fixedSize(horizontal: true, vertical: true)
        .listRowBackground(Color.clear)
    }
    
    private var cardBackgroundColor: Color {
        colorScheme == .light
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
    SavedPlantCardView()
}
