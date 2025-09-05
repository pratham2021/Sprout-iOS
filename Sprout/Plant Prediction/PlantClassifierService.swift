//
//  PlantClassifierService.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/4/25.
//

import Foundation
import UIKit

@MainActor
class PlantClassifierService: ObservableObject {
    
    // Replace with your actual RapidAPI key
    let rapidAPIKey = PLANT_PREDICTION_API_KEY
    private let rapidAPIHost = "plant-classifier.p.rapidapi.com"
    
    @Published var isLoading = false
    @Published var predictions: [PlantPrediction] = []
    @Published var errorMessage: String?
    @Published var rawResponse: String?
    
    // MARK: - Main Classification Method
    func classifyPlant(image: UIImage) async {
        isLoading = true
        errorMessage = nil
        predictions = []
        
        defer { isLoading = false }
        
        do {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                throw PlantClassifierError.imageConversionFailed
            }
            
            guard let url = URL(string: "https://plant-classifier.p.rapidapi.com/plantclassifier/prediction") else {
                throw PlantClassifierError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Set headers
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(rapidAPIKey, forHTTPHeaderField: "X-RapidAPI-Key")
            request.setValue(rapidAPIHost, forHTTPHeaderField: "X-RapidAPI-Host")
            
            // Convert image to base64
            let base64String = imageData.base64EncodedString()
            let requestBody = [
                "image": "data:image/jpeg;base64,\(base64String)"
            ]
            
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            
            // Make the request
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Parse response
            let classificationResponse = try JSONDecoder().decode(PlantClassificationResponse.self, from: data)
            
            if classificationResponse.predictions.count != 0 {
                let responsePredictions = classificationResponse.predictions
                predictions = responsePredictions
            } else {
                errorMessage = "No predictions received"
            }
            
        } catch {
            errorMessage = error.localizedDescription
            print("Classification error: \(error)")
        }
    }
    
}
