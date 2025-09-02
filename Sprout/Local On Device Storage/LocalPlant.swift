//
//  LocalPlant.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/18/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class LocalPlant {
    
    @Attribute(.unique) var name: String
    var scientificName: String
    var dateSaved: Date
    var isVegetable: Bool
    var plantImageUrl: String
    var isEdible: Bool
    var ediblePart: [String]?
    var duration: [String]?
    
    var flowerColor: [String]?
    var hasConspicuousFlower: Bool?
    
    var foliageTexture: String?
    var foliageColor: [String]?
    var leafRetention: Bool?
    
    var isFruitConspicuous: Bool?
    var fruitColor: [String]?
    var fruitShape: String?
    var fruitSeedPersistence: Bool?
    
    var growthForm: String?
    var growthHabit: String?
    var growthRate: String?
    
    var averageHeight: Int?
    var maximumHeight: Int?
    
    var nitrogenFixation: String?
    var shapeAndOrientation: String?
    var toxicity: String?
    
    var growthDescription: String?
    var sowingDescription: String?
    var daysToHarvest: Double?
    var phMaximum: Double?
    var phMinimum: Double?
    var light: Int?
    var atmosphericHumidity: Int?
    
    let growthMonths: [String]? // The most active growth months of the species
    let bloomMonths: [String]? // The months the species usually blooms
    let fruitMonths: [String]? // The months the species usually produces fruits
    
    var rowSpacingCM: Int?
    var rowSpacingMM: Int?
    
    var spreadCM: Int?
    var spreadMM: Int?
    
    var minimumPrecipitationCM: Int?
    var minimumPrecipitationMM: Int?
    
    var maximumPrecipitationCM: Int?
    var maximumPrecipitationMM: Int?
    
    var minimumRootDepthCM: Int?
    var minimumRootDepthMM: Int?
    
    var minimumTempFahrenheit: Double?
    var minimumTempCelsius: Double?
    var maximumTempFahrenheit: Double?
    var maximumTempCelsius: Double?

    var soilNutriments: Int? // Required quantity of soil nutriments, from 0 (oligotrophic) to 10 (hypereutrophic)
    var soilSalinity: Int? // Tolerance to salinity, on a scale from 0 (untolerant) to 10 (hyperhaline)
    var soilTexture: Int? // Required texture of the soil, on a scale from 0 (clay) to 10 (rock)
    var soilHumidity: Int? // Required humidity of the soil, on a scale from 0 (xerophile) to 10 (subaquatic)
    
    init(name: String, scientificName: String, dateSaved: Date, isVegetable: Bool, plantImageUrl: String, isEdible: Bool, ediblePart: [String]? = nil, duration: [String]? = nil, flowerColor: [String]? = nil, hasConspicuousFlower: Bool? = nil, foliageTexture: String? = nil, foliageColor: [String]? = nil, leafRetention: Bool? = nil, isFruitConspicuous: Bool? = nil, fruitColor: [String]? = nil, fruitShape: String? = nil, fruitSeedPersistence: Bool? = nil, growthForm: String? = nil, growthHabit: String? = nil, growthRate: String? = nil, averageHeight: Int? = nil, maximumHeight: Int? = nil, nitrogenFixation: String? = nil, shapeAndOrientation: String? = nil, toxicity: String? = nil, growthDescription: String? = nil, sowingDescription: String? = nil, daysToHarvest: Double? = nil, phMaximum: Double? = nil, phMinimum: Double? = nil, light: Int? = nil, atmosphericHumidity: Int? = nil, growthMonths: [String]?, bloomMonths: [String]?, fruitMonths: [String]?, rowSpacingCM: Int? = nil, rowSpacingMM: Int? = nil, spreadCM: Int? = nil, spreadMM: Int? = nil, minimumPrecipitationCM: Int? = nil, minimumPrecipitationMM: Int? = nil, maximumPrecipitationCM: Int? = nil, maximumPrecipitationMM: Int? = nil, minimumRootDepthCM: Int? = nil, minimumRootDepthMM: Int? = nil, minimumTempFahrenheit: Double? = nil, minimumTempCelsius: Double? = nil, maximumTempFahrenheit: Double? = nil, maximumTempCelsius: Double? = nil, soilNutriments: Int? = nil, soilSalinity: Int? = nil, soilTexture: Int? = nil, soilHumidity: Int? = nil) {
        self.name = name
        self.scientificName = scientificName
        self.dateSaved = dateSaved
        self.isVegetable = isVegetable
        self.plantImageUrl = plantImageUrl
        self.isEdible = isEdible
        self.ediblePart = ediblePart
        self.duration = duration
        self.flowerColor = flowerColor
        self.hasConspicuousFlower = hasConspicuousFlower
        self.foliageTexture = foliageTexture
        self.foliageColor = foliageColor
        self.leafRetention = leafRetention
        self.isFruitConspicuous = isFruitConspicuous
        self.fruitColor = fruitColor
        self.fruitShape = fruitShape
        self.fruitSeedPersistence = fruitSeedPersistence
        self.growthForm = growthForm
        self.growthHabit = growthHabit
        self.growthRate = growthRate
        self.averageHeight = averageHeight
        self.maximumHeight = maximumHeight
        self.nitrogenFixation = nitrogenFixation
        self.shapeAndOrientation = shapeAndOrientation
        self.toxicity = toxicity
        self.growthDescription = growthDescription
        self.sowingDescription = sowingDescription
        self.daysToHarvest = daysToHarvest
        self.phMaximum = phMaximum
        self.phMinimum = phMinimum
        self.light = light
        self.atmosphericHumidity = atmosphericHumidity
        self.growthMonths = growthMonths
        self.bloomMonths = bloomMonths
        self.fruitMonths = fruitMonths
        self.rowSpacingCM = rowSpacingCM
        self.rowSpacingMM = rowSpacingMM
        self.spreadCM = spreadCM
        self.spreadMM = spreadMM
        self.minimumPrecipitationCM = minimumPrecipitationCM
        self.minimumPrecipitationMM = minimumPrecipitationMM
        self.maximumPrecipitationCM = maximumPrecipitationCM
        self.maximumPrecipitationMM = maximumPrecipitationMM
        self.minimumRootDepthCM = minimumRootDepthCM
        self.minimumRootDepthMM = minimumRootDepthMM
        self.minimumTempFahrenheit = minimumTempFahrenheit
        self.minimumTempCelsius = minimumTempCelsius
        self.maximumTempFahrenheit = maximumTempFahrenheit
        self.maximumTempCelsius = maximumTempCelsius
        self.soilNutriments = soilNutriments
        self.soilSalinity = soilSalinity
        self.soilTexture = soilTexture
        self.soilHumidity = soilHumidity
    }
}
