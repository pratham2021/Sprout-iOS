//
//  SettingsView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            List {
                Section {
                    HStack {
                        Text("PH")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(textColor)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Pratham Hebbar")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(textColor)
                                .padding(.top, 4)
                            
                            Text("prathamhebbar2021@gmail.com")
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                .background(Color.clear)
                
                Section("General") {
                    
                }
                
                Section("Account") {
                    
                }
            }
        }

    }
    
    
    private var backgroundColor: Color {
        colorScheme == .dark
        ? Color(red: 250/255, green: 187/255, blue: 139/255)
        : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

#Preview {
    SettingsView()
}
