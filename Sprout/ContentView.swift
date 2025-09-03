//
//  ContentView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView().transition(.opacity)
            }
            else {
                LoginView().transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.userSession != nil)
    }
}

#Preview {
    ContentView()
}
