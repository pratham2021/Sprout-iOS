//
//  PlantDisease.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/10/25.
//

import Foundation

struct PlantDisease: Codable {
    let id: Int
    let commonName: String
    let scientificName: String
    let otherName: [String]?
    let family: String?
    let description: [DescriptionSection]
    let solution: [SolutionSection]
    let host: [String]
    let images: [DiseaseImage]
    
    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case otherName = "other_name"
        case family
        case description
        case solution
        case host
        case images
    }
}
