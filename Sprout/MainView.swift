//
//  ContentView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = 0
    

    var body: some View {
        TabView(selection: $selectedTab) {
            SavedView()
                .tabItem {
                    Image(systemName: "square.and.arrow.down")
                    Text("Saved")
                }
                .tag(0)

            SearchView()
                .tabItem {
                    Image(systemName: "text.page.badge.magnifyingglass")
                    Text("Search")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
        .tint(tabTintColor)
        .toolbarBackground(tabBarBackgroundColor, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .onAppear {
            updateTabBarAppearance(for: colorScheme)
        }
        .onChange(of: colorScheme) { _, newColorScheme in
            updateTabBarAppearance(for: newColorScheme)
        }
    }

    var tabTintColor: Color {
         colorScheme == .dark
         ? Color(red: 92/255, green: 157/255, blue: 82/255)
         : Color(red: 48/255, green: 91/255, blue: 38/255)
    }

    var tabBarBackgroundColor: Color {
        colorScheme == .dark
        ? Color(red: 250/255, green: 187/255, blue: 139/255)
        : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    func updateTabBarAppearance(for scheme: ColorScheme) {
        let unselectedColor = scheme == .dark ? UIColor(red: 0.3, green: 0.2, blue: 0.1, alpha: 1.0) : UIColor(red: 0.2, green: 0.15, blue: 0.1, alpha: 0.8)

        let backgroundColor = scheme == .dark ? UIColor(red: 250/255, green: 187/255, blue: 139/255, alpha: 1.0) : UIColor(red: 244/255, green: 218/255, blue: 198/255, alpha: 1.0)

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
           
        appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor]

        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first {
                updateTabBarsInView(window, with: appearance)
            }
        }
           
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
       
    private func updateTabBarsInView(_ view: UIView, with appearance: UITabBarAppearance) {
        if let tabBar = view as? UITabBar {
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
           
        for subview in view.subviews {
            updateTabBarsInView(subview, with: appearance)
        }
    }
}

#Preview {
    MainView()
}
