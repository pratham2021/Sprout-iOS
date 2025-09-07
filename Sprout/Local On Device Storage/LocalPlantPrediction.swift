//
//  LocalPlantPrediction.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/5/25.
//


import Foundation
import UIKit
import SwiftData

@Model
class LocalPlantPrediction {
    
    var scientificName: String
    var probability: Double
    
    init(scientificName: String, probability: Double) {
        self.scientificName = scientificName
        self.probability = probability
    }
}
