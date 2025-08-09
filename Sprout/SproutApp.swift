//
//  SproutApp.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

@main
struct SproutApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    @StateObject var locationManager = LocationManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(locationManager)
        }
    }
}
