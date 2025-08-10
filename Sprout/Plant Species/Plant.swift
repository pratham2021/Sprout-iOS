//
//  Plant.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/10/25.
//

import Foundation

struct Plant: Codable {
    let id: Int
    let commonName: String?
    let scientificName: [String]?
    let otherName: [String]?
    let family: String?
    let hybrid: String?
    let authority: String?
    let subspecies: String?
    let cultivar: String?
    let variety: String?
    let speciesEpithet: String?
    let genus: String?
    let defaultImage: PlantImage?
    
    enum CodingKeys: String, CodingKey {
        case id, family, hybrid, authority, subspecies, cultivar, variety, genus
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case otherName = "other_name"
        case speciesEpithet = "species_epithet"
        case defaultImage = "default_image"
    }
}
