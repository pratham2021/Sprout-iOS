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
    // @Published var predictions: [PlantPrediction] = []
    // @Published var errorMessage: String?
    @Published var rawResponse: String?
    
    // MARK: - Main Classification Method
    func classifyPlant(image: UIImage, completion: @escaping ([PlantPrediction], String) -> Void) async {
        isLoading = true
        
        defer { isLoading = false }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            // throw PlantClassifierError.imageConversionFailed
            completion([], "Failed to convert image into JPG")
            return
        }
        
        guard let url = URL(string: "https://plant-classifier.p.rapidapi.com/plantclassifier/prediction") else {
            completion([], "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30.0
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(PLANT_PREDICTION_API_KEY, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue(rapidAPIHost, forHTTPHeaderField: "X-RapidAPI-Host")
        
        let base64String = imageData.base64EncodedString()
        let requestBody = [
            "image": "data:image/jpeg;base64,\(base64String)"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion([], "Failed to create request body")
            return
        }
        
        var errorString = "Invalid response"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion([], errorString)
                return
            }
            
            errorString = "No data"
            
            let classificationResponse = try JSONDecoder().decode(PlantClassificationResponse.self, from: data)
            
            guard !classificationResponse.predictions.isEmpty else {
                completion([], errorString)
                return
            }
            
            errorString = ""
            completion(classificationResponse.predictions, errorString)
            return
        }
        catch {
            completion([], errorString)
            return
        }
    }
}
