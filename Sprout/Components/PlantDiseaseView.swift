//
//  PlantDiseaseView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/11/25.
//

import SwiftUI

struct PlantDiseaseView: View {
    
    var plantDisease: PlantDisease
    
    var body: some View {
        Text("Plant Diseases")
    }
}

#Preview {
    PlantDiseaseView(plantDisease: PlantDisease(id: 1, common_name: "Fairy ring", scientific_name: "Agrocybe", other_name: nil, family: nil, description:
        [
            DescriptionSection(subtitle: "What is Fairy Ring (Agrocybe)?", description: "A fairy ring is a lawn issue where circular bands of dark green or dying grass appear. Different fungi like Agrocybe, Marasmius oreades, and Lepiota species cause it. Fairy rings can be found on lawns worldwide. The size and shape of the rings depend on the fungus and environment. Common symptoms of the fairy ring include forming a ring pattern with vibrant or dead grass. Some fungi produce mushrooms without rings, while others create rings without mushrooms. This issue affects actively growing turf, including cool-season and Bermudagrass."),
            DescriptionSection(subtitle: "How Does Fairy Ring Occur?", description: "Fairy rings are formed when underground fungal mycelia expand in a circular pattern. They release spores from mushrooms at the ring's edge, which can spread through air, animals, or water to create new colonies. The mycelia consume nutrients and cause the circular pattern to grow, resulting in fairy rings.")
        ], solution: [
            SolutionSection(subtitle: "Cultural Practices", description: "•\tPractice proper turfgrass management, including fertilization, irrigation, and maintenance.\n•\tAvoid excessive thatch buildup by regular dethatching if it exceeds 1/2 inch (1.2 cm).\n•\tEnsure good drainage and avoid overwatering.\n•\tMinimize organic matter accumulation by removing grass clippings and debris.\n•\tUse fully decomposed compost and organic material.\n•\tMonitor and control weeds to prevent their invasion.\n•\tAvoid spreading infected soil or thatch to healthy areas.\n\n"),
            SolutionSection(subtitle: "Chemical Treatment", description: "•  Propiconazole, thiophanate-methyl, Azoxystrobin (Heritage) and flutolanil (Prostar WG) are fungicides that can hinder the growth of fairy ring-causing fungi. These fungicides either inhibit the fungi's respiration process or disrupt their cell membrane synthesis.\n Follow the manufacturer's instructions carefully.")
        ],
        host: ["all lawn grasses"],
        images: [
            DiseaseImage(license: 45,
                         license_name: "Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)",
                         license_url: "https://creativecommons.org/licenses/by-sa/3.0/deed.en",
                         original_url: "https://perenual.com/storage/species_disease/1_a/og/Fairy_ring_-_geograph.org.uk_-_1057031.jpg",
                         regular_url: "https://perenual.com/storage/species_disease/1_a/regular/Fairy_ring_-_geograph.org.uk_-_1057031.jpg",
                         medium_url: "https://perenual.com/storage/species_disease/1_a/medium/Fairy_ring_-_geograph.org.uk_-_1057031.jpg",
                         small_url: "https://perenual.com/storage/species_disease/1_a/small/Fairy_ring_-_geograph.org.uk_-_1057031.jpg",
                         thumbnail: "https://perenual.com/storage/species_disease/1_a/thumbnail/Fairy_ring_-_geograph.org.uk_-_1057031.jpg"),
            DiseaseImage(license: 4,
                         license_name: "Attribution License",
                         license_url: "https://creativecommons.org/licenses/by/2.0/",
                         original_url: "https://perenual.com/storage/species_disease/1_a/og/7810714166_e1b9c10965_b.jpg",
                         regular_url: "https://perenual.com/storage/species_disease/1_a/regular/7810714166_e1b9c10965_b.jpg",
                         medium_url: "https://perenual.com/storage/species_disease/1_a/medium/7810714166_e1b9c10965_b.jpg",
                         small_url: "https://perenual.com/storage/species_disease/1_a/small/7810714166_e1b9c10965_b.jpg",
                         thumbnail: "https://perenual.com/storage/species_disease/1_a/thumbnail/7810714166_e1b9c10965_b.jpg"),
            DiseaseImage(license: 9,
                         license_name: "Public Domain Dedication (CC0)",
                         license_url: "https://creativecommons.org/publicdomain/zero/1.0/",
                         original_url: "https://perenual.com/storage/species_disease/1_a/og/5794681214_d97177b332_b.jpg",
                         regular_url: "https://perenual.com/storage/species_disease/1_a/regular/5794681214_d97177b332_b.jpg",
                         medium_url: "https://perenual.com/storage/species_disease/1_a/medium/5794681214_d97177b332_b.jpg",
                         small_url: "https://perenual.com/storage/species_disease/1_a/small/5794681214_d97177b332_b.jpg",
                         thumbnail: "https://perenual.com/storage/species_disease/1_a/thumbnail/5794681214_d97177b332_b.jpg")
        ]
    ))
}
