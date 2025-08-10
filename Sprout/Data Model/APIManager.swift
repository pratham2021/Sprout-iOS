//  APIManager.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/9/2025.

import Foundation

func fetchSpecies(completion: @escaping ([Plant]) -> Void) async {
    
    let apiKey = await PERENUAL_API_KEY
    
    guard let url = URL(string: "https://perenual.com/api/v2/species-list?hardiness=4-8&key=\(apiKey)") else {
        completion([])
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    print(request.url?.absoluteString)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            // print("Error:", error)
            completion([])
            return
        }
                   
        guard let httpResponse = response as? HTTPURLResponse else {
            completion([])
            return
        }
               
        print(httpResponse.url)
        
        if let data = data {
            let decoder = JSONDecoder()
            do {
                
                completion([])
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

func fetchSpeciesCareGuide() async {
    
}

func fetchPestDisease() async {
    
    
}
