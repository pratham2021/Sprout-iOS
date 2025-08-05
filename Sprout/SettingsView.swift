//
//  SettingsView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        
        ZStack {
            colorScheme == .dark ? Color(red: 250/255, green: 187/255, blue: 139/255).ignoresSafeArea() : Color(red: 244/255, green: 218/255, blue: 198/255).ignoresSafeArea()
            
        
            Text("Customize your settings").foregroundColor(Color.black)
        }

    }
}

#Preview {
    SettingsView(colorScheme: .constant(.light))
}
