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
    let license_name: String
    let license_url: String
    let original_url: String
    let regular_url: String
    let medium_url: String
    let small_url: String
    let thumbnail: String
}
