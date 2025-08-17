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
    let daysToHarvest: Int?
    let rowSpacing: Distance
    let spread: Distance
    let phMaximum: Double?
    let phMinimum: Double?
    let light: String?
    let atmosphericHumidity: String?
    let growthMonths: [String]?
    let bloomMonths: [String]?
    let fruitMonths: [String]?
    let minimumPrecipitation: Distance
    let maximumPrecipitation: Distance
    let minimumRootDepth: Distance
    let minimumTemperature: Temperature
    let maximumTemperature: Temperature
    let soilNutriments: String?
    let soilSalinity: String?
    let soilTexture: String?
    let soilHumidity: String?
    
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
