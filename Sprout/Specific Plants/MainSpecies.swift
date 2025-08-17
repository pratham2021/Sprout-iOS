//
//  MainSpecies.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct MainSpecies: Codable {
    let id: Int
    let commonName: String?
    let slug: String
    let scientificName: String
   
    let year: Int?
    let status: String?
    
    let edible: Bool?
    let ediblePart: [String]?
    let duration: [String]?
    
    let images: Images
    let commonNames: [String: [String]]
    let distribution: [String: [String]]
    let distributions: SpeciesDistributions
    let flower: FlowerInfo
    let foliage: FoliageInfo
    let fruitOrSeed: FruitOrSeedInfo
    let specifications: Specifications
    let growth: Growth
    
    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case slug
        case scientificName = "scientific_name"
        case year
        case status
        case edible
        case ediblePart = "edible_part"
        case duration
        case images
        case commonNames = "common_names"
        case distribution
        case distributions
        case flower
        case foliage
        case fruitOrSeed = "fruit_or_seed"
        case specifications
        case growth
    }
}
