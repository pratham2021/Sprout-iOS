//
//  ContentView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var currentScheme: ColorScheme = .light
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SavedView(colorScheme: $currentScheme)
                .tabItem {
                    VStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Saved")
                    }
                }
                .tag(0)
            
            SearchView(colorScheme: $currentScheme)
                .tabItem {
                    VStack {
                        Image(systemName: "text.page.badge.magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(1)
            
            SettingsView(colorScheme: $currentScheme)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .tag(2)
        }
        .id(colorScheme)
        .tint(
            colorScheme == .dark ? Color(red: 92/255, green: 157/255, blue: 82/255) : Color(red: 48/255, green: 91/255, blue: 38/255)
        )
        .onAppear {
            currentScheme = colorScheme
            updateTabBarColor(for: currentScheme)
        }
        .onChange(of: colorScheme) { newScheme in
            currentScheme = newScheme
            updateTabBarColor(for: newScheme)
        }
    }
    
    public func updateTabBarColor(for scheme: ColorScheme) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = scheme == .dark ? UIColor(red: 250/255, green: 187/255, blue: 139/255, alpha: 1) : UIColor(red: 244/255, green: 218/255, blue: 198/255, alpha: 1)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

#Preview {
    ContentView()
}
