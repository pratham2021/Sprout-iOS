//
//  SpeciesLinks.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/12/25.
//

import Foundation

struct SpeciesLinks: Codable {
    let selfLink: String
    let plant: String
    let genus: String
    
    private enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case plant
        case genus
    }
}
