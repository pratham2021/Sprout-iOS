//  Specifications.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/16/2025.

import Foundation

struct Specifications: Codable {
    let ligneousType: String?
    let growthForm: String?
    let growthHabit: String?
    let growthRate: String?
    let averageHeight: Height
    let maximumHeight: Height
    let nitrogenFixation: Bool?
    let shapeAndOrientation: String?
    let toxicity: String?
    
    enum CodingKeys: String, CodingKey {
        case ligneousType = "ligneous_type"
        case growthForm = "growth_form"
        case growthHabit = "growth_habit"
        case growthRate = "growth_rate"
        case averageHeight = "average_height"
        case maximumHeight = "maximum_height"
        case nitrogenFixation = "nitrogen_fixation"
        case shapeAndOrientation = "shape_and_orientation"
        case toxicity
    }
}
