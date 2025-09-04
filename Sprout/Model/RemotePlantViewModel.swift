//
//  RemotePlantViewModel.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/4/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class RemotePlantViewModel: ObservableObject {
    
    @Published var remotePlants = [RemotePlant]()
    
    func getData(userID: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection(userID).addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        self.remotePlants = snapshot.documents.map { document in
                            return self.createRemotePlant(from: document.data())
                        }
                    }
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.remotePlants = []
                }
            }
        }
    }
    
    private func createRemotePlant(from data: [String: Any]) -> RemotePlant {
        return RemotePlant(
            name: data["name"] as? String ?? "",
            scientificName: (data["scientificName"] as? String)!,
            dateSaved: (data["dateSaved"] as? Timestamp)?.dateValue() ?? Date(),
            isVegetable: data["isVegetable"] as? Bool ?? false,
            plantImageUrl: data["plantImageUrl"] as? String ?? "",
            isEdible: data["isEdible"] as? Bool ?? false,
            ediblePart: data["ediblePart"] as? [String],
            duration: data["duration"] as? [String],
            flowerColor: data["flowerColor"] as? [String] ?? [],
            hasConspicuousFlower: data["hasConspicuousFlower"] as? Bool,
            foliageTexture: data["foliageTexture"] as? String ?? "Unknown",
            foliageColor: data["foliageColor"] as? [String] ?? [],
            leafRetention: data["leafRetention"] as? Bool,
            isFruitConspicuous: data["isFruitConspicuous"] as? Bool,
            fruitColor: data["fruitColor"] as? [String] ?? [],
            fruitShape: data["fruitShape"] as? String ?? "Unknown",
            fruitSeedPersistence: data["fruitSeedPersistence"] as? Bool,
            growthForm: data["growthForm"] as? String ?? "Unknown",
            growthHabit: data["growthHabit"] as? String ?? "Unknown",
            growthRate: data["growthRate"] as? String ?? "Unknown",
            averageHeight: data["averageHeight"] as? Int,
            maximumHeight: data["maximumHeight"] as? Int,
            nitrogenFixation: data["nitrogenFixation"] as? String ?? "Unknown",
            shapeAndOrientation: data["shapeAndOrientation"] as? String ?? "Unknown",
            toxicity: data["toxicity"] as? String ?? "Unknown",
            growthDescription: data["growthDescription"] as? String ?? "Unknown",
            sowingDescription: data["sowingDescription"] as? String ?? "Unknown",
            daysToHarvest: data["daysToHarvest"] as? Double,
            phMaximum: data["phMaximum"] as? Double,
            phMinimum: data["phMinimum"] as? Double,
            light: data["light"] as? Int,
            atmosphericHumidity: data["atmosphericHumidity"] as? Int,
            growthMonths: data["growthMonths"] as? [String] ?? [],
            bloomMonths: data["bloomMonths"] as? [String] ?? [],
            fruitMonths: data["fruitMonths"] as? [String] ?? [],
            rowSpacingCM: data["rowSpacingCM"] as? Int,
            rowSpacingMM: data["rowSpacingMM"] as? Int,
            spreadCM: data["spreadCM"] as? Int,
            spreadMM: data["spreadMM"] as? Int,
            minimumPrecipitationCM: data["minimumPrecipitationCM"] as? Int,
            minimumPrecipitationMM: data["minimumPrecipitationMM"] as? Int,
            maximumPrecipitationCM: data["maximumPrecipitationCM"] as? Int,
            maximumPrecipitationMM: data["maximumPrecipitationMM"] as? Int,
            minimumRootDepthCM: data["minimumRootDepthCM"] as? Int,
            minimumRootDepthMM: data["minimumRootDepthMM"] as? Int,
            minimumTempFahrenheit: data["minimumTempFahrenheit"] as? Double,
            minimumTempCelsius: data["minimumTempCelsius"] as? Double,
            maximumTempFahrenheit: data["maximumTempFahrenheit"] as? Double,
            maximumTempCelsius: data["maximumTempCelsius"] as? Double,
            soilNutriments: data["soilNutriments"] as? Int,
            soilSalinity: data["soilSalinity"] as? Int,
            soilTexture: data["soilTexture"] as? Int,
            soilHumidity: data["soilHumidity"] as? Int
        )
    }
    
}

//var id: String = UUID().uuidString
//var name: String
//var scientificName: String
//var dateSaved: Date
//var isVegetable: Bool
//var plantImageUrl: String
//var isEdible: Bool
//var ediblePart: [String]?
//var duration: [String]?
//
//var flowerColor: [String]?
//var hasConspicuousFlower: Bool?
//
//var foliageTexture: String?
//var foliageColor: [String]?
//var leafRetention: Bool?
//
//var isFruitConspicuous: Bool?
//var fruitColor: [String]?
//var fruitShape: String?
//var fruitSeedPersistence: Bool?
//
//var growthForm: String?
//var growthHabit: String?
//var growthRate: String?
//
//var averageHeight: Int?
//var maximumHeight: Int?
//
//var nitrogenFixation: String?
//var shapeAndOrientation: String?
//var toxicity: String?
//
//var growthDescription: String?
//var sowingDescription: String?
//var daysToHarvest: Double?
//var phMaximum: Double?
//var phMinimum: Double?
//var light: Int?
//var atmosphericHumidity: Int?
//
//let growthMonths: [String]? // The most active growth months of the species
//let bloomMonths: [String]? // The months the species usually blooms
//let fruitMonths: [String]? // The months the species usually produces fruits
//
//var rowSpacingCM: Int?
//var rowSpacingMM: Int?
//
//var spreadCM: Int?
//var spreadMM: Int?
//
//var minimumPrecipitationCM: Int?
//var minimumPrecipitationMM: Int?
//
//var maximumPrecipitationCM: Int?
//var maximumPrecipitationMM: Int?
//
//var minimumRootDepthCM: Int?
//var minimumRootDepthMM: Int?
//
//var minimumTempFahrenheit: Double?
//var minimumTempCelsius: Double?
//var maximumTempFahrenheit: Double?
//var maximumTempCelsius: Double?
//
//var soilNutriments: Int? // Required quantity of soil nutriments, from 0 (oligotrophic) to 10 (hypereutrophic)
//var soilSalinity: Int? // Tolerance to salinity, on a scale from 0 (untolerant) to 10 (hyperhaline)
//var soilTexture: Int? // Required texture of the soil, on a scale from 0 (clay) to 10 (rock)
//var soilHumidity: Int?
