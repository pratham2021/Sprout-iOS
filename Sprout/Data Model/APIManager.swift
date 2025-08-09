//  APIManager.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/9/2025.

import Foundation

// MARK: - Fetch Fruits

func fetchFruits(zip: String, completion: @escaping ([Plant]) -> Void) {
    var urlString = "https://verdantly-gardening-api.p.rapidapi.com/v1/plants/varieties/filter?category=fruit"
    
    guard let url = URL(string: urlString) else {
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    request.addValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    request.addValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            // print("Error:", error)
            completion([])
            return
        }
        
        print(error?.localizedDescription)
            
        guard let httpResponse = response as? HTTPURLResponse else {
            completion([])
            return
        }
        
        print(httpResponse.url)
            
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let plantResponse = try decoder.decode(PlantResponse.self, from: data)
                completion(plantResponse.data)
            } catch {
                completion([])
            }
        }
        else {
            completion([])
        }
    }
        
    task.resume()
}


// MARK: - Fetch Flowers
func fetchFlowers(zip: String, completion: @escaping ([Plant]) -> Void) {
    var urlString = "https://verdantly-gardening-api.p.rapidapi.com/v1/plants/varieties/filter?category=flower"
    
//    if zip != "" {
//        fetchZone(for: zip) { zone in
//            
//            if let zone = zone {
//                urlString = "https://verdantly-gardening-api.p.rapidapi.com/v1/plants/varieties/filter?category=flower&hardiness_zone=\(zone)"
//            }
//        }
//    }
    
    guard let url = URL(string: urlString) else {
        // print("Invalid URL")
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    request.addValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    request.addValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    
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
                let plantResponse = try decoder.decode(PlantResponse.self, from: data)
                completion(plantResponse.data)
            } catch {
                completion([])
            }
        }
        else {
            completion([])
        }
    }
        
    task.resume()
}

// MARK: - Herbs
func fetchHerbs(zip: String, completion: @escaping ([Plant]) -> Void) {
    var urlString = "https://verdantly-gardening-api.p.rapidapi.com/v1/plants/varieties/filter?category=herb"
    
    
    guard let url = URL(string: urlString) else {
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    request.addValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    request.addValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    
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
                let plantResponse = try decoder.decode(PlantResponse.self, from: data)
                completion(plantResponse.data)
            } catch {
                completion([])
            }
        }
        else {
            completion([])
        }
    }
        
    task.resume()
}

// MARK: - Vegetables
func fetchVegetables(zip: String, completion: @escaping ([Plant]) -> Void) {
    var urlString = "https://verdantly-gardening-api.p.rapidapi.com/v1/plants/varieties/filter?category=vegetable"
    
//    if zip != "" {
//        fetchZone(for: zip) { zone in
//            if let zone = zone {
//                urlString = "https://verdantly-gardening-api.p.rapidapi.com/v1/plants/varieties/filter?category=vegetable&hardiness_zone=\(zone)"
//                print(urlString)
//            }
//        }
//    }

    guard let url = URL(string: urlString) else {
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    request.addValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    request.addValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    
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
                let plantResponse = try decoder.decode(PlantResponse.self, from: data)
                completion(plantResponse.data)
            } catch {
                completion([])
            }
        }
        else {
            completion([])
        }
    }
        
    task.resume()
}

// MARK: - Fetch Zone
func fetchZone(for zip: String, completion: @escaping (String?) -> Void) {
    guard let url = URL(string: "https://verdantly-gardening-api.p.rapidapi.com/v1/hardiness-zones/zipcode/\(zip)") else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.addValue(RAPID_API_KEY, forHTTPHeaderField: "x-rapidapi-key")
    request.addValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let httpResponse = response as? HTTPURLResponse else {
            print("No HTTP response")
            completion(nil)
            return
        }
        print("Status code:", httpResponse.statusCode)
        
        guard let data = data, error == nil, httpResponse.statusCode == 200 else {
            print("Data error or status code not 200")
            completion(nil)
            return
        }
        
        if let responseString = String(data: data, encoding: .utf8) {
            print("Response JSON:", responseString)
        }
        
        // Try to parse assuming 'zone' might be nested inside 'data'
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            if let zone = json["zone"] as? String {
                completion(zone)
                return
            } else if let dataDict = json["data"] as? [String: Any],
                      let zone = dataDict["zone"] as? String {
                completion(zone)
                return
            }
        }
        
        completion(nil)
    }.resume()
}
