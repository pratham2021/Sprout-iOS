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
    
    init() {
        FirebaseApp.configure()
        
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(red: 244/255, green: 218/255, blue: 198/255, alpha: 1.0)
//        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0.2, green: 0.15, blue: 0.1, alpha: 0.8)
//        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 0.2, green: 0.15, blue: 0.1, alpha: 0.8)]
//
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
