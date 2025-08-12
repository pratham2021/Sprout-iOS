//  PlantCardView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/11/2025

import SwiftUI

struct PlantCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var plant: Plant
    
    @State var plantSpecies: PlantSpecies = PlantSpecies(id: 1, commonName: "European Silver Fir", scientificName: ["Abies alba"], otherName: ["Common Silver Fir"], family: nil, hybrid: nil, authority: nil, subspecies: nil, cultivar: nil, variety: nil, speciesEpithet: "alba", genus: "Abies", origin: ["Austria", "Germany", "Switzerland", "France", "Italy", "Slovenia", "Croatia", "Bosnia and Herzegovina", "Serbia", "Montenegro", "Albania", "Bulgaria", "Romania", "Ukraine", "Poland", "Czech Republic", "Slovakia", "Hungary"], type: "tree", dimensions: [Dimension(type: "Height", minValue: 60, maxValue: 60, unit: "feet")], cycle: "Perennial", attracts: [], propagation: ["Cutting", "Grafting Propagation", "Layering Propagation", "Seed Propagation", "Air Layering Propagation", "Tissue Culture"], hardiness: Hardiness(min: "7", max: "7"), hardinessLocation: HardinessLocation(fullUrl: "https://perenual.com/api/hardiness-map?species_id=1&size=og&key=sk-3olN68980eddb45b811727", fullIframe: "<iframe frameborder=0 scrolling=yes seamless=seamless width=1000 height=550 style='margin:auto;' src='https://perenual.com/api/hardiness-map?species_id=1&size=og&key=sk-3olN68980eddb45b811727'></iframe>"), watering: "Frequent", wateringGeneralBenchmark: WateringBenchmark(value: "\"7-10\"", unit: "days"), plantAnatomy: [], sunlight: ["full sun"], pruningMonth: ["February", "March", "April"], pruningCount: [], seeds: false, maintenance: nil, careGuides: "http://perenual.com/api/species-care-guide-list?species_id=1&key=sk-3olN68980eddb45b811727", soil: [], growthRate: "High", droughtTolerant: false, saltTolerant: false, thorny: false, invasive: false, tropical: false, indoor: false, careLevel: "Medium", pestSusceptibility: [], flowers: false, floweringSeason: nil, cones: true, fruits: false, edibleFruit: false, harvestSeason: nil, leaf: true, edibleLeaf: false, cuisine: false, medicinal: true, poisonousToHumans: false, poisonousToPets: false, description: "European Silver Fir (Abies alba) is an amazing coniferous species native to mountainous regions of central Europe and the Balkans. It is an evergreen tree with a narrow, pyramidal shape and long, soft needles. Its bark is scaly grey-brown and its branches are highly ornamental due to its conical-shaped silver-tinged needles. It is pruned for use as an ornamental evergreen hedging and screening plant, and is also popular for use as a Christmas tree. Young trees grow quickly and have strong, flexible branches which makes them perfect for use as windbreaks. The European Silver Fir is an impressive species, making it ideal for gardens and public spaces.", defaultImage: DefaultImage(license: 45, licenseName: "Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)", licenseUrl: "https://creativecommons.org/licenses/by-sa/3.0/deed.en", originalUrl: "https://perenual.com/storage/species_image/1_abies_alba/og/1536px-Abies_alba_SkalitC3A9.jpg", regularUrl: "https://perenual.com/storage/species_image/1_abies_alba/regular/1536px-Abies_alba_SkalitC3A9.jpg", mediumUrl: "https://perenual.com/storage/species_image/1_abies_alba/medium/1536px-Abies_alba_SkalitC3A9.jpg", smallUrl: "https://perenual.com/storage/species_image/1_abies_alba/small/1536px-Abies_alba_SkalitC3A9.jpg", thumbnail: "https://perenual.com/storage/species_image/1_abies_alba/thumbnail/1536px-Abies_alba_SkalitC3A9.jpg")
    )
    
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
        .task {
            await fetchPlantSpeciesDetail(plant: plant) { speciesPlant in
                print(speciesPlant.count)
                if speciesPlant.count > 0 {
                    plantSpecies = speciesPlant[0]
                }
            }
            
        }
        .onTapGesture {
            if plantSpecies != nil {
                print(plantSpecies.id)
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
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

#Preview {
    PlantCardView(plant: Plant(id: 1, commonName: "European Silver Fir", scientificName: ["Abies alba"], otherName: ["Common Silver Fir"], family: nil, hybrid: nil, authority: nil, subspecies: nil, cultivar: nil, variety: nil, speciesEpithet: "alba", genus: "Abies", defaultImage: PlantImage(license: 45, licenseName: "Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)", licenseUrl: "https://creativecommons.org/licenses/by-sa/3.0/deed.en", originalUrl: "https://perenual.com/storage/species_image/1_abies_alba/og/1536px-Abies_alba_SkalitC3A9.jpg", regularUrl: "https://perenual.com/storage/species_image/1_abies_alba/regular/1536px-Abies_alba_SkalitC3A9.jpg", mediumUrl: "https://perenual.com/storage/species_image/1_abies_alba/medium/1536px-Abies_alba_SkalitC3A9.jpg", smallUrl: "https://perenual.com/storage/species_image/1_abies_alba/small/1536px-Abies_alba_SkalitC3A9.jpg", thumbnail: "https://perenual.com/storage/species_image/1_abies_alba/thumbnail/1536px-Abies_alba_SkalitC3A9.jpg")), plantSpecies:
                    PlantSpecies(id: 1, commonName: "European Silver Fir", scientificName: ["Abies alba"],
                                 otherName: ["Common Silver Fir"], family: nil, hybrid: nil, authority: nil, subspecies: nil, cultivar: nil, variety: nil, speciesEpithet: "alba", genus: "Abies", origin: [
                                    "Austria", "Germany", "Switzerland", "France", "Italy", "Slovenia", "Croatia", "Bosnia and Herzegovina", "Serbia", "Montenegro", "Albania", "Bulgaria", "Romania", "Ukraine", "Poland", "Czech Republic", "Slovakia", "Hungary"
                                  ],
                                 type: "tree", dimensions: [Dimension(type: "Height", minValue: 60, maxValue: 60, unit: "feet")],
                                 cycle: "Perennial", attracts: [], propagation: ["Cutting", "Grafting Propagation", "Layering Propagation", "Seed Propagation", "Air Layering Propagation", "Tissue Culture"], hardiness: Hardiness(min: "7", max: "7"), hardinessLocation: HardinessLocation(fullUrl: "https://perenual.com/api/hardiness-map?species_id=1&size=og&key=sk-3olN68980eddb45b811727", fullIframe: "<iframe frameborder=0 scrolling=yes seamless=seamless width=1000 height=550 style='margin:auto;' src='https://perenual.com/api/hardiness-map?species_id=1&size=og&key=sk-3olN68980eddb45b811727'></iframe>"), watering: "Frequent", wateringGeneralBenchmark: WateringBenchmark(value: "\"7-10\"", unit: "days"), plantAnatomy: [], sunlight: ["full sun"], pruningMonth: ["February", "March", "April"], pruningCount: [], seeds: false, maintenance: nil, careGuides: "http://perenual.com/api/species-care-guide-list?species_id=1&key=sk-3olN68980eddb45b811727", soil: [], growthRate: "High", droughtTolerant: false, saltTolerant: false, thorny: false, invasive: false, tropical: false, indoor: false, careLevel: "Medium", pestSusceptibility: [], flowers: false, floweringSeason: nil, cones: true, fruits: false, edibleFruit: false, harvestSeason: nil, leaf: true, edibleLeaf: false, cuisine: false, medicinal: true, poisonousToHumans: false, poisonousToPets: false, description: "European Silver Fir (Abies alba) is an amazing coniferous species native to mountainous regions of central Europe and the Balkans. It is an evergreen tree with a narrow, pyramidal shape and long, soft needles. Its bark is scaly grey-brown and its branches are highly ornamental due to its conical-shaped silver-tinged needles. It is pruned for use as an ornamental evergreen hedging and screening plant, and is also popular for use as a Christmas tree. Young trees grow quickly and have strong, flexible branches which makes them perfect for use as windbreaks. The European Silver Fir is an impressive species, making it ideal for gardens and public spaces.", defaultImage: DefaultImage(
                                    license: 45,
                                    licenseName: "Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)",
                                    licenseUrl: "https://creativecommons.org/licenses/by-sa/3.0/deed.en",
                                    originalUrl: "https://perenual.com/storage/species_image/1_abies_alba/og/1536px-Abies_alba_SkalitC3A9.jpg",
                                    regularUrl: "https://perenual.com/storage/species_image/1_abies_alba/regular/1536px-Abies_alba_SkalitC3A9.jpg",
                                    mediumUrl: "https://perenual.com/storage/species_image/1_abies_alba/medium/1536px-Abies_alba_SkalitC3A9.jpg",
                                    smallUrl: "https://perenual.com/storage/species_image/1_abies_alba/small/1536px-Abies_alba_SkalitC3A9.jpg",
                                    thumbnail: "https://perenual.com/storage/species_image/1_abies_alba/thumbnail/1536px-Abies_alba_SkalitC3A9.jpg"))
    )
}
