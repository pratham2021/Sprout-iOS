//  APIManager.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/9/2025.

import Foundation

func fetchPlants(completion: @escaping ([PlantSpecies]) -> Void) async {
    
    let apiKey = await PERENUAL_API_KEY
    
    guard let url = URL(string: "https://trefle.io/api/v1/plants?token=\(apiKey)") else {
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion([])
            return
        }
                   
        guard let httpResponse = response as? HTTPURLResponse else {
            completion([])
            return
        }
                       
        if let data = data {
            let decoder = JSONDecoder()
            
            do {
                let decodedResponse = try decoder.decode(PlantResponse.self, from: data)
                completion(decodedResponse.data)
            }
            catch {
                completion([])
            }
        }
        else {
            completion([])
        }
    }
    
    task.resume()
}

func fetchDistribution(completion: @escaping ([Distribution]) -> Void) async {
    
    let apiKey = await PERENUAL_API_KEY
    
    guard let url = URL(string: "https://trefle.io/api/v1/distributions?token=\(apiKey)") else {
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion([])
            return
        }
                   
        guard let httpResponse = response as? HTTPURLResponse else {
            completion([])
            return
        }
                       
        if let data = data {
            let decoder = JSONDecoder()
            
            do {
                let decodedResponse = try decoder.decode(DistributionResponse.self, from: data)
                completion(decodedResponse.data)
            }
            catch {
                completion([])
            }
        }
        else {
            completion([])
        }
    }
    
    task.resume()
}

func fetchPlantByDistribution(distributionId: Int, completion: @escaping ([PlantSpecies]) -> Void) async {
    
    let apiKey = await PERENUAL_API_KEY
    
    guard let url = URL(string: "https://trefle.io/api/v1/distributions/\(distributionId)/plants?token=\(apiKey)") else {
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion([])
            return
        }
                   
        guard let httpResponse = response as? HTTPURLResponse else {
            completion([])
            return
        }
                       
        if let data = data {
            let decoder = JSONDecoder()
            
            do {
                let decodedResponse = try decoder.decode(PlantResponse.self, from: data)
                completion(decodedResponse.data)
            }
            catch {
                completion([])
            }
        }
        else {
            completion([])
        }
    }
    
    task.resume()
}

//func fetchDistributionPlantByName(plantName, ) async {
//    
//}
