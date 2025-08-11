//
//  DiseaseImage.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/10/25.
//

import Foundation

// MARK: - Disease Image
struct DiseaseImage: Codable {
    let license: Int
    let licenseName: String
    let licenseURL: String
    let originalURL: String
    let regularURL: String
    let mediumURL: String
    let smallURL: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case license
        case licenseName = "license_name"
        case licenseURL = "license_url"
        case originalURL = "original_url"
        case regularURL = "regular_url"
        case mediumURL = "medium_url"
        case smallURL = "small_url"
        case thumbnail
    }
}
