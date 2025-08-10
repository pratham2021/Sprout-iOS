//
//  PlantImage.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/10/25.
//

import Foundation

struct PlantImage: Codable {
    let license: Int?
    let licenseName: String?
    let licenseUrl: String?
    let originalUrl: String?
    let regularUrl: String?
    let mediumUrl: String?
    let smallUrl: String?
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case license, thumbnail
        case licenseName = "license_name"
        case licenseUrl = "license_url"
        case originalUrl = "original_url"
        case regularUrl = "regular_url"
        case mediumUrl = "medium_url"
        case smallUrl = "small_url"
    }
}
