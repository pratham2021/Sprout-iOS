//  APIManager.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/9/2025.

import Foundation

// Plant information provided by Trefle.io
func fetchPlants(completion: @escaping ([PlantSpecies]) -> Void) async {
    
    let apiKey = await PLANT_API_KEY
    
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

func fetchSpecificPlant(id: Int, completion: @escaping (PlantData?) -> Void) async {
    
    let apiKey = await PLANT_API_KEY
    
    guard let url = URL(string: "https://trefle.io/api/v1/plants/\(id)?token=\(apiKey)") else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil)
            return
        }
                   
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(nil)
            return
        }
                       
        if let data = data {
            let decoder = JSONDecoder()
            
            do {
                let decodedResponse = try decoder.decode(SpecificPlantResponse.self, from: data)
                completion(decodedResponse.data)
            }
            catch {
                print(id)
                completion(nil)
            }
        }
        else {
            completion(nil)
        }
    }
    
    task.resume()
}


// MARK: - Distributions
func fetchDistributions(completion: @escaping ([Distribution]) -> Void) async {
    
    let apiKey = await PLANT_API_KEY
    
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


func fetchSpecificDistribution(distributionId: Int, completion: @escaping ([Distribution]) -> Void) async {
    
    let apiKey = await PLANT_API_KEY
    
    guard let url = URL(string: "https://trefle.io/api/v1/distributions/\(distributionId)?token=\(apiKey)") else {
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
                let decoderResponse = try decoder.decode(DistributionResponse.self, from: data)
                completion(decoderResponse.data)
            }
            catch {
                completion([])
                return
            }
        }
        else {
            completion([])
        }
    }
    
    task.resume()
}

func fetchPlantsInDistribution(plantEndpoint: String, completion: @escaping ([PlantSpecies]) -> Void) async {
    
    let apiKey = await PLANT_API_KEY
    
    let string = "https://trefle.io\(plantEndpoint)?token=\(apiKey)"
    
    guard let url = URL(string: "https://trefle.io\(plantEndpoint)?token=\(apiKey)") else {
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
                let decoderResponse = try decoder.decode(PlantResponse.self, from: data)
                completion(decoderResponse.data)
            }
            catch {
                completion([])
                return
            }
        }
        else {
            completion([])
        }
    }
    
    task.resume()
}

func fetchEdiblePlants(completion: @escaping ([EdiblePlantSpecies]) -> Void) async {
    
    let apiKey = await PLANT_API_KEY
    
    let string = "https://trefle.io/api/v1/plants?filter_not%5Bedible_part%5D=null&token=\(apiKey)"
    
    guard let url = URL(string: string) else {
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
                let decoderResponse = try decoder.decode(EdiblePlantResponse.self, from: data)
                completion(decoderResponse.data)
            }
            catch {
                completion([])
                return
            }
        }
        else {
            completion([])
        }
    }
    
    task.resume()
}

func fetchEdiblePlant(plantId: Int, completion: @escaping(PlantData?) -> Void) async {
    
    let apiKey = await PLANT_API_KEY
    
    let string = "https://trefle.io/api/v1/plants/\(plantId)?token=\(apiKey)"
    
    guard let url = URL(string: string) else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(nil)
            return
        }
        
        if let data = data {
            let decoder = JSONDecoder()
            
            do {
                let decoderResponse = try decoder.decode(SpecificPlantResponse.self, from: data)
                completion(decoderResponse.data)
            }
            catch {
                completion(nil)
                print("Parsing failed")
                return
            }
        }
        else {
            completion(nil)
        }
    }
    
    task.resume()
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
