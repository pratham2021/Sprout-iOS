//
//  LocationManager.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/9/25.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    @Published var zipCode: String?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        manager.delegate = self
        checkAuthorization()
    }
    
    func checkAuthorization() {
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                break
            case .authorizedWhenInUse, .authorizedAlways:
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.requestLocation()
            @unknown default:
                break
        }
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.zipCode = placemark.postalCode
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
