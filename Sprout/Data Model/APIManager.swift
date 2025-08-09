//  APIManager.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/9/2025.

import Foundation


func fetchFruits() async {
    guard let url = URL(string: "https://verdantly-gardening-api.p.rapidapi.com/v1/fruits") else {
        print("Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    request.setValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    
    print(request.url?.absoluteString)
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }
        
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            print(json)
            print("\n")
        } else if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            print(jsonArray)
        }
        
    } catch {
        print("Error: \(error)")
    }
}

func fetchFlowers() async {
    guard let url = URL(string: "https://verdantly-gardening-api.p.rapidapi.com/v1/flowers") else {
        print("Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    request.setValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    
    print(request.url?.absoluteString)
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }
        
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            print(json)
        } else if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            print(jsonArray)
        }
        
    } catch {
        print("Error: \(error)")
    }
}

func fetchHerbs() async {
    guard let url = URL(string: "https://verdantly-gardening-api.p.rapidapi.com/v1/herbs") else {
        print("Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    request.setValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    
    print(request.url?.absoluteString)
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }
        
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            print(json)
        } else if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            print(jsonArray)
        }
        
    } catch {
        print("Error: \(error)")
    }
}


func fetchVegetables() async {
    guard let url = URL(string: "https://verdantly-gardening-api.p.rapidapi.com/v1/vegetables") else {
        print("Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("\(RAPID_API_KEY)", forHTTPHeaderField: "X-RapidAPI-Key")
    request.setValue("verdantly-gardening-api.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    
    print(request.url?.absoluteString)
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }
        
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            print(json)
        } else if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            print(jsonArray)
        }
        
    } catch {
        print("Error: \(error)")
    }
}
