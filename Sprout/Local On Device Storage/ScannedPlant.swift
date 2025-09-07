//
//  ScannedPlant.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/5/25.
//

import Foundation
import UIKit
import SwiftData

@Model
class ScannedPlant {

    var imageData: Data?
    
    var image: UIImage? {
        if imageData != nil {
            UIImage(data: imageData!)
        }
        else {
            UIImage(named: "golden-pothos")
        }
    }
    
    var plantPredictions: [LocalPlantPrediction]
    
    init(imageData: Data? = nil, plantPredictions: [LocalPlantPrediction]) {
        self.imageData = imageData
        self.plantPredictions = plantPredictions
    }
}
