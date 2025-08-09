//
//  CareInstructions.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/9/25.
//

import Foundation

struct CareInstructions: Codable {
    let harvestingInstructions: String
    let plantingInstructions: PlantingInstructions
    let pruningInstructions: String
}
