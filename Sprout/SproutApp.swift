//
//  SproutApp.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import Firebase
import FirebaseAuth
import FirebaseCore
import SwiftUI
import SwiftData

@main
struct SproutApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: [LocalPlant.self])
        
    }
}
