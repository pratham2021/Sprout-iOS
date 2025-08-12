//
//  Dimension.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/12/25.
//

import Foundation

struct Dimension: Codable {
    let type: String
    let minValue: Int
    let maxValue: Int
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case minValue = "min_value"
        case maxValue = "max_value"
        case unit
    }
}

