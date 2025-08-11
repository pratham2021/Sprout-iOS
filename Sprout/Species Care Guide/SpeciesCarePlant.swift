//  SpeciesCarePlant.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/10/2025.


// MARK: - Plant Structure
struct SpeciesCarePlant: Codable, Identifiable {
    let id: Int
    let speciesID: Int
    let commonName: String
    let scientificName: [String]
    let section: [CareSection]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case speciesID = "species_id"
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case section
    }
}
