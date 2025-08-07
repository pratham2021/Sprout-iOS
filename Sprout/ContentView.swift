//
//  ContentView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/7/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            backgroundColor
            
            GeometryReader { screen in
                VStack(spacing: screen.size.height * 0.03) {
                    
                    Text("Welcome to Sprout")
                            .foregroundColor(textColor)
                            .font(.system(size: min(screen.size.width * 0.1, 38), weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.7)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.top, screen.safeAreaInsets.top + (screen.size.height * 0.08))
                    
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .tint(textColor)
                            .foregroundColor(textColor)
                            .textFieldStyle(.plain)
                            .placeholder(when: email.isEmpty) {
                                Text("Email")
                                    .foregroundColor(textColor)
                                    .bold()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(textColor.opacity(0.3), lineWidth: 1)
                            )
                        
                        SecureField("Password", text: $password)
                            .tint(textColor)
                            .foregroundColor(textColor)
                            .textFieldStyle(.plain)
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(textColor)
                                    .bold()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(textColor.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button("Log In") {
                            if email.isEmpty || password.isEmpty {
                                return
                            }
                            
                        }
                        .foregroundColor(textColor)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(textColor.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .frame(maxWidth: min(screen.size.width * 0.9, 400))
                    
                    Spacer()
                }
                .frame(maxWidth: 350)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .ignoresSafeArea()
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

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    ContentView()
}
