//
//  SproutApp.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import Firebase
import SwiftUI
import SwiftData

@main
struct SproutApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [LocalPlant.self])
        
    }
}
