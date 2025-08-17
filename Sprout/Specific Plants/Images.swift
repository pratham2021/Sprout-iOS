//
//  Images.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct Images: Codable {
    let leaf: [PlantImage]?
    let bark: [PlantImage]?
    let habit: [PlantImage]?
    let fruit: [PlantImage]?
    
    enum CodingKeys: String, CodingKey {
        case leaf, bark, habit, fruit
    }
}
