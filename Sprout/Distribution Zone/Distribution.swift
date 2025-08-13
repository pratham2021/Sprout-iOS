//  Distribution.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/12/2025.

import Foundation

struct Distribution: Codable {
    let id: Int
    let name: String
    let slug: String
    let tdwgCode: String
    let tdwgLevel: Int
    let speciesCount: Int
    let parent: ParentDistribution?
    let children: [ChildDistribution]
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, parent, children
        case tdwgCode = "tdwg_code"
        case tdwgLevel = "tdwg_level"
        case speciesCount = "species_count"
    }
}
