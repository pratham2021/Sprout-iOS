//
//  SavedPlantCardView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/13/25.
//

import Foundation
import SwiftUI
import SwiftData

struct SavedPlantCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var savedPlant: LocalPlant
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(cardBackgroundColor)
                .opacity(0.8)
                .cornerRadius(15)
            
            VStack(spacing: 10) {
                Text(savedPlant.name)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
                if savedPlant.plantImageUrl != "golden-pothos" {
                    AsyncImage(url: URL(string: savedPlant.plantImageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Image("golden-pothos")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                else {
                    Image("golden-pothos")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                VStack(spacing: 4) {
                    Text(savedPlant.scientificName)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(textColor)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        
                    Text(formatDate(date: savedPlant.dateSaved))
                        .font(.caption2)
                        .foregroundColor(textColor.opacity(0.8))
                }
                // .frame(height: 40)
            }
            .padding(12)
        }
        .frame(width: 120, height: 160)
        .listRowBackground(Color.clear)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: date)
        return dateString
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

//#Preview {
//    SavedPlantCardView()
//}
