//
//  SpeciesDistributions.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct SpeciesDistributions: Codable {
    let native: [SpeciesDistribution]?
    let introduced: [SpeciesDistribution]?
}
