//
//  Temperature.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct Temperature: Codable {
    let degF: Double?
    let degC: Double?
    
    enum CodingKeys: String, CodingKey {
        case degF = "deg_f"
        case degC = "deg_c"
    }
}
