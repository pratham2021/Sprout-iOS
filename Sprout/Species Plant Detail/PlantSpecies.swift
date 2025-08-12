//
//  PlantSpecies.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/12/25.
//

import Foundation

struct PlantSpecies: Codable {
    let id: Int
    let commonName: String
    let scientificName: [String]
    let otherName: [String]
    let family: String?
    let hybrid: String?
    let authority: String?
    let subspecies: String?
    let cultivar: String?
    let variety: String?
    let speciesEpithet: String
    let genus: String
    let origin: [String]
    let type: String
    let dimensions: [Dimension]
    let cycle: String
    let attracts: [String]
    let propagation: [String]
    let hardiness: Hardiness
    let hardinessLocation: HardinessLocation
    let watering: String
    let wateringGeneralBenchmark: WateringBenchmark
    let plantAnatomy: [String]
    let sunlight: [String]
    let pruningMonth: [String]
    let pruningCount: [String]
    let seeds: Bool
    let maintenance: String?
    let careGuides: String
    let soil: [String]
    let growthRate: String
    let droughtTolerant: Bool
    let saltTolerant: Bool
    let thorny: Bool
    let invasive: Bool
    let tropical: Bool
    let indoor: Bool
    let careLevel: String
    let pestSusceptibility: [String]
    let flowers: Bool
    let floweringSeason: String?
    let cones: Bool
    let fruits: Bool
    let edibleFruit: Bool
    let harvestSeason: String?
    let leaf: Bool
    let edibleLeaf: Bool
    let cuisine: Bool
    let medicinal: Bool
    let poisonousToHumans: Bool
    let poisonousToPets: Bool
    let description: String
    let defaultImage: DefaultImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case otherName = "other_name"
        case family
        case hybrid
        case authority
        case subspecies
        case cultivar
        case variety
        case speciesEpithet = "species_epithet"
        case genus
        case origin
        case type
        case dimensions
        case cycle
        case attracts
        case propagation
        case hardiness
        case hardinessLocation = "hardiness_location"
        case watering
        case wateringGeneralBenchmark = "watering_general_benchmark"
        case plantAnatomy = "plant_anatomy"
        case sunlight
        case pruningMonth = "pruning_month"
        case pruningCount = "pruning_count"
        case seeds
        case maintenance
        case careGuides = "care_guides"
        case soil
        case growthRate = "growth_rate"
        case droughtTolerant = "drought_tolerant"
        case saltTolerant = "salt_tolerant"
        case thorny
        case invasive
        case tropical
        case indoor
        case careLevel = "care_level"
        case pestSusceptibility = "pest_susceptibility"
        case flowers
        case floweringSeason = "flowering_season"
        case cones
        case fruits
        case edibleFruit = "edible_fruit"
        case harvestSeason = "harvest_season"
        case leaf
        case edibleLeaf = "edible_leaf"
        case cuisine
        case medicinal
        case poisonousToHumans = "poisonous_to_humans"
        case poisonousToPets = "poisonous_to_pets"
        case description
        case defaultImage = "default_image"
    }
}
