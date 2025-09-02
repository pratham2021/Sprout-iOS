//
//  ContentView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/8/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Group {
            MainView().transition(.opacity)
        }
        .animation(.easeInOut(duration: 0.3), value: true)
    }
}

#Preview {
    ContentView()
}
