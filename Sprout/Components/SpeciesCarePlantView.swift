//
//  SpeciesCarePlant.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/11/25.
//

import SwiftUI

struct SpeciesCarePlantView: View {
    
    var speciesCarePlant: SpeciesCarePlant
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    SpeciesCarePlantView(speciesCarePlant: SpeciesCarePlant(id: 1, speciesID: 352, commonName: "Ambrosia Apple", scientificName: ["Malus Ambrosia"], section: [
        CareSection(id: 1, type: .watering, description: "Ambrosia Apple (Malus 'Ambrosia') plants require regular watering, especially during the flowering and fruiting season. Generally, they require 1-2 inches of water per week (including rainfall). If the soil is allowed to become too dry, the plant's growth and fruit production can be affected. During the spring and summer months, it is important to water your Ambrosia Apple deeply and thoroughly, at least twice a week. Once established, the plant is highly drought tolerant and will require less watering during fall and winter."),
        CareSection(id: 2, type: .sunlight, description: "Ambrosia Apple (Malus 'Ambrosia') needs at least 8 hours of sunlight each day for optimal growth and fruiting. For best results, the plant should receive direct sunlight for 4 to 6 hours in the morning and again in the afternoon for 2 to 4 hours. A few hours of indirect sunlight in the middle of the day can also provide the additional light needed to help the plant thrive. Too much direct sunlight (especially in the afternoon) can cause leaf scorching and dehydrate the plant, so it is important to provide light shading if your plant is in an area with direct exposure to the sun."),
        CareSection(id: 3, type: .pruning, description: "The Ambrosia Apple (Malus 'Ambrosia') should be pruned in early spring, before bud break. Pruning should be done to maintain the desired shape of the tree and to remove dead or damaged branches. The tree should also be pruned to open the canopy and increase air circulation and light penetration. Large branches should be cut back to a branch collar and thin out areas of dense growth. No more than 1-third of the branches should be removed in any pruning session.")
    ]))
}
