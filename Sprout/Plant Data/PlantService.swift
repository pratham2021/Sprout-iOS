//
//  PlantService.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/9/25.
//

import Foundation

class PlantService {
    var fruits: [Plant] = []
    
    func fetchFruits(completion: @escaping ([Plant]) -> Void) {
        let urlString = "https://verdantly-gardening-api.p.rapidapi.com/v1/plants/varieties/filter?category=fruit"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue("\(RAPID_API_KEY)", forHTTPHeaderField: "x-rapidapi-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error:", error)
                completion([])
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let plantResponse = try decoder.decode(PlantResponse.self, from: data)
                self.fruits = plantResponse.data
                
                DispatchQueue.main.async {
                    completion(plantResponse.data)
                }
                
            } catch {
                print("Failed to decode PlantResponse:", error)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        
        task.resume()
    }
