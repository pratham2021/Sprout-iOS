//  HardinessLocation.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/12/2025.

struct HardinessLocation: Codable {
    let fullUrl: String
    let fullIframe: String
    
    enum CodingKeys: String, CodingKey {
        case fullUrl = "full_url"
        case fullIframe = "full_iframe"
    }
}
