//
//  FruitOrSeedInfo.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct FruitOrSeedInfo: Codable {
    let conspicuous: Bool?
    let color: String?
    let shape: String?
    let seedPersistence: String?
        
    enum CodingKeys: String, CodingKey {
        case conspicuous, color, shape
        case seedPersistence = "seed_persistence"
    }
}
