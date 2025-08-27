//  PlantSaveError.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/26/2025

import Foundation

enum PlantSaveError: LocalizedError {
    case duplicateName(String)
    
    var errorDescription: String? {
        switch self {
        case .duplicateName(let name):
            return "A plant named '\(name)' already exists"
        }
    }
}
