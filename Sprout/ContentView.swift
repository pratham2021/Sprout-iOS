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
                MainView()
            }
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
