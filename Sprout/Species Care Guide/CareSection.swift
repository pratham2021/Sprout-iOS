//  SpeciesCareGuide.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/10/2025.

import Foundation

struct CareSection: Codable, Identifiable {
    let id: Int
    let type: CareType
    let description: String
}
