//
//  Plant.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/9/25.
//

import Foundation

struct Plant: Codable {
    let id: String
    let mappingId: String
    let name: String
    let description: String
    let category: String
    let type: String
    let subtype: String
    let commonUses: String
    let highlights: String
    let history: String
    let pestAndDiseaseRisks: String
    let careInstructions: CareInstructions
    let growingRequirements: GrowingRequirements
    let growthDetails: GrowthDetails
    let lifecycleMilestones: LifecycleMilestones
    let species: Species
}
