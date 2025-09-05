//
//  PlantClassifierError.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/4/25.
//

import Foundation

enum PlantClassifierError: Error, LocalizedError {
    case imageConversionFailed
    case invalidURL
    case noData
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .imageConversionFailed:
            return "Failed to convert image to JPEG data"
        case .invalidURL:
            return "Invalid API URL"
        case .noData:
            return "No data received from server"
        case .invalidResponse:
            return "Invalid response format"
        }
    }
}
