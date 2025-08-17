//
//  FoliageInfo.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct FoliageInfo: Codable {
    let texture: String?
    let color: [String]?
    let leafRetention: Bool?
    
    enum CodingKeys: String, CodingKey {
        case texture, color
        case leafRetention = "leaf_retention"
    }
}
