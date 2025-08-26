//  PlantData.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/16/2025.

import Foundation

struct PlantData: Decodable {
    let id: Int
    let commonName: String?
    let slug: String
    let scientificName: String
    let mainSpeciesId: Int
    let imageUrl: String?
    let observations: String
    let vegetable: Bool?
    let mainSpecies: MainSpecies

    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case slug
        case scientificName = "scientific_name"
        case mainSpeciesId = "main_species_id"
        case imageUrl = "image_url"
        case observations = "observations"
        case vegetable
        case mainSpecies = "main_species"
    }
}
