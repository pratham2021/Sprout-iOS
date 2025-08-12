//  PlantCardView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/11/2025

import SwiftUI

struct PlantCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var plant: Plant
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Rectangle()
                    .background {
                        if let imageURL = plant.defaultImage?.originalUrl {
                            AsyncImage(url: URL(string: imageURL)) { phase in
                                switch phase {
                                case .empty:
                                    Image("golden-pothos")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        
                                case .failure:
                                    Image("golden-pothos")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                @unknown default:
                                    Image("golden-pothos")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                        else {
                            Image("golden-pothos")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .foregroundColor(.clear)
                
                Text(plant.commonName ?? "Plant Not Found")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(textColor)
            }
        }
        .frame(width: 120, height: 120)
        .cornerRadius(15)
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
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

#Preview {
    PlantCardView(plant: Plant(id: 1, commonName: "European Silver Fir", scientificName: ["Abies alba"], otherName: ["Common Silver Fir"], family: nil, hybrid: nil, authority: nil, subspecies: nil, cultivar: nil, variety: nil, speciesEpithet: "alba", genus: "Abies", defaultImage: PlantImage(license: 45, licenseName: "Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)", licenseUrl: "https://creativecommons.org/licenses/by-sa/3.0/deed.en", originalUrl: "https://perenual.com/storage/species_image/1_abies_alba/og/1536px-Abies_alba_SkalitC3A9.jpg", regularUrl: "https://perenual.com/storage/species_image/1_abies_alba/regular/1536px-Abies_alba_SkalitC3A9.jpg", mediumUrl: "https://perenual.com/storage/species_image/1_abies_alba/medium/1536px-Abies_alba_SkalitC3A9.jpg", smallUrl: "https://perenual.com/storage/species_image/1_abies_alba/small/1536px-Abies_alba_SkalitC3A9.jpg", thumbnail: "https://perenual.com/storage/species_image/1_abies_alba/thumbnail/1536px-Abies_alba_SkalitC3A9.jpg")))
}
