//
//  Growth.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/16/25.
//

import Foundation

struct Growth: Codable {
    let description: String?
    let sowing: String?
    let daysToHarvest: Double?
    let phMaximum: Double? // of the top 30 centimeters of soil
    let phMinimum: Double? // of the top 30 centimeters of soil
    let light: Int? // lux
    let atmosphericHumidity: Int? // %
    
    let growthMonths: [String]? // The most active growth months of the species
    let bloomMonths: [String]? // The months the species usually blooms
    let fruitMonths: [String]? // The months the species usually produces fruits
    
    let rowSpacing: Distance // cm
    let spread: Distance // cm
    
    let minimumPrecipitation: Distance // mm
    let maximumPrecipitation: Distance // mm
    let minimumRootDepth: Distance // mm
    
    let minimumTemperature: Temperature // degF or degC
    let maximumTemperature: Temperature // degF or degC
    
    let soilNutriments: Int? // Required quantity of soil nutriments, from 0 (oligotrophic) to 10 (hypereutrophic)
    let soilSalinity: Int? // Tolerance to salinity, on a scale from 0 (untolerant) to 10 (hyperhaline)
    let soilTexture: Int? // Required texture of the soil, on a scale from 0 (clay) to 10 (rock)
    let soilHumidity: Int? // Required humidity of the soil, on a scale from 0 (xerophile) to 10 (subaquatic)
    
    enum CodingKeys: String, CodingKey {
        case description, sowing
        case daysToHarvest = "days_to_harvest"
        case rowSpacing = "row_spacing"
        case spread
        case phMaximum = "ph_maximum"
        case phMinimum = "ph_minimum"
        case light
        case atmosphericHumidity = "atmospheric_humidity"
        case growthMonths = "growth_months"
        case bloomMonths = "bloom_months"
        case fruitMonths = "fruit_months"
        case minimumPrecipitation = "minimum_precipitation"
        case maximumPrecipitation = "maximum_precipitation"
        case minimumRootDepth = "minimum_root_depth"
        case minimumTemperature = "minimum_temperature"
        case maximumTemperature = "maximum_temperature"
        case soilNutriments = "soil_nutriments"
        case soilSalinity = "soil_salinity"
        case soilTexture = "soil_texture"
        case soilHumidity = "soil_humidity"
    }
}
