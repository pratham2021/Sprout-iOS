//  PlantCardView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/11/2025

import SwiftUI

struct PlantCardView: View {
    
    var plant: Plant
    
    var body: some View {
        Text("Plant Card View")
    }
}

#Preview {
    PlantCardView(plant: Plant(id: 1, commonName: "European Silver Fir", scientificName: ["Abies alba"], otherName: ["Common Silver Fir"], family: nil, hybrid: nil, authority: nil, subspecies: nil, cultivar: nil, variety: nil, speciesEpithet: "alba", genus: "Abies", defaultImage: PlantImage(license: 45, licenseName: "Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)", licenseUrl: "https://creativecommons.org/licenses/by-sa/3.0/deed.en", originalUrl: "https://perenual.com/storage/species_image/1_abies_alba/og/1536px-Abies_alba_SkalitC3A9.jpg", regularUrl: "https://perenual.com/storage/species_image/1_abies_alba/regular/1536px-Abies_alba_SkalitC3A9.jpg", mediumUrl: "https://perenual.com/storage/species_image/1_abies_alba/medium/1536px-Abies_alba_SkalitC3A9.jpg", smallUrl: "https://perenual.com/storage/species_image/1_abies_alba/small/1536px-Abies_alba_SkalitC3A9.jpg", thumbnail: "https://perenual.com/storage/species_image/1_abies_alba/thumbnail/1536px-Abies_alba_SkalitC3A9.jpg")))
}
