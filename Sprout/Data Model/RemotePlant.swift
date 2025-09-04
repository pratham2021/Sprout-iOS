//
//  RemotePlant.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/4/25.
//

import Foundation

struct RemotePlant: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var name: String
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
    var soilHumidity: Int?
}
