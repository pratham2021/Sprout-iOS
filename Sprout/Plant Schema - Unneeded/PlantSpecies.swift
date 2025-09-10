//
//  Plant.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/12/25.
//

import Foundation

struct PlantSpecies: Codable {
    let id: Int
    let commonName: String?
    let slug: String
    let scientificName: String
    let year: Int
    let bibliography: String
    let author: String
    let status: String
    let rank: String
    let familyCommonName: String?
    let genusID: Int
    let imageURL: String?
    let synonyms: [String]
    let genus: String
    let family: String
    let links: SpeciesLinks
    
    private enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case slug
        case scientificName = "scientific_name"
        case year
        case bibliography
        case author
        case status
        case rank
        case familyCommonName = "family_common_name"
        case genusID = "genus_id"
        case imageURL = "image_url"
        case synonyms
        case genus
        case family
        case links
    }
}
