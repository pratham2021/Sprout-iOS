//
//  GrowingRequirements.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/9/25.
//

import Foundation

struct GrowingRequirements: Codable {
    let careInstructions: String
    let growingZoneRange: String
    let maxGrowingZone: Int
    let minGrowingZone: Int
    let preferredTemperature: String
    let soilPreference: String
    let spacingRequirement: String
    let sunlightRequirement: String
    let waterRequirement: String
}
