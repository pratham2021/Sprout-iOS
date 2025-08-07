//  Contentview.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/7/2025.

import SwiftUI

struct ContentView: View {
    
    @State private var screen: [String] = []
    
    var body: some View {
        
        NavigationStack(path: $screen) {
            VStack {
                
            }
            .navigationDestination(for: String.self) { s in
                if s == "Main" {
                    MainView()
                }
                else if s == "Auth" {
                    AuthView()
                }
            }
        }
        .onAppear {
            
        }
    }
}

#Preview {
    ContentView()
}
