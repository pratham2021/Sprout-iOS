//
//  PlantImage.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct PlantImage: Codable {
    let id: Int
    let imageUrl: String
    let copyright: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case copyright
    }
}
