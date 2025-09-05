//
//  PlantClassificationResponse.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/4/25.
//

import Foundation


struct PlantClassificationResponse: Codable {
    let predictions: [PlantPrediction]
}
