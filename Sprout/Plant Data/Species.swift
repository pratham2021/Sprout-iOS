//
//  File.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/9/25.
//

import Foundation

struct Species: Codable {
    let id: String?
    let commonName: String?
    let scientificName: String?
    let nativeStatus: String?
    let distribution: Distribution?
    let growthDetails: SpeciesGrowthDetails?
    let taxonomy: Taxonomy?
}
