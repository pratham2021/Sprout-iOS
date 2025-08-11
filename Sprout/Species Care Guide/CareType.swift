//  CareType.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/10/25.

import Foundation

// MARK: - Care Type Enum
enum CareType: String, Codable, CaseIterable {
    case watering = "watering"
    case sunlight = "sunlight"
    case pruning = "pruning"
    
    var displayName: String {
        switch self {
        case .watering:
            return "Watering"
        case .sunlight:
            return "Sunlight"
        case .pruning:
            return "Pruning"
        }
    }
    
    var icon: String {
        switch self {
            case .watering:
                return "drop.fill"
            case .sunlight:
                return "thermometer.sun"
            case .pruning:
                return "scissors"
        }
    }
}
