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
    @Published var rawResponse: String?
    
    // MARK: - Main Classification Method
    func classifyPlant(image: UIImage, completion: @escaping ([PlantPrediction], String) -> Void) async {
        isLoading = true
        
        defer { isLoading = false }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion([], "Failed to convert image into JPG")
            return
        }
        
        guard let url = URL(string: "https://plant-classifier.p.rapidapi.com/plantclassifier/prediction") else {
            completion([], "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10.0
        
        let boundary = "---011000010111000001101001"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(PLANT_PREDICTION_API_KEY, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue(rapidAPIHost, forHTTPHeaderField: "X-RapidAPI-Host")
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        var errorString = "Invalid response"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion([], "HTTP Error: \(httpResponse.statusCode)")
                return
            }
            
            errorString = "No data"
            
            let classificationResponse = try JSONDecoder().decode([PlantPrediction].self, from: data)
            
            guard !classificationResponse.isEmpty else {
                completion([], errorString)
                return
            }
            
            errorString = ""
            completion(classificationResponse, errorString)
            return
        }
        catch {
            completion([], errorString)
            return
        }
    }
}
