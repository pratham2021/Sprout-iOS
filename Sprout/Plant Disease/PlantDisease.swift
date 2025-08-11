//
//  PlantDisease.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/10/25.
//

import Foundation

struct PlantDisease: Codable {
    let id: Int
    let common_name: String
    let scientific_name: String
    let other_name: String?
    let family: String?
    let description: [DescriptionSection]
    let solution: [SolutionSection]
    let host: [String]
    let images: [DiseaseImage]
}
