//  SignInView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/7/25.

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var email = ""
    @State private var password = ""
    @State private var userAuthenticated = false
    
    var body: some View {
        if userAuthenticated {
            MainView()
        }
        else {
            content
        }
    }
    
    var content: some View {
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
                    
                    VStack(spacing: 30) {
                        
                        VStack(spacing: 0) {
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
                            
                            Rectangle()
                                .frame(width: .infinity, height: 1)
                                .foregroundColor(textColor)
                                .padding(.horizontal, 16)
                        }
                        
                        VStack(spacing: 0) {
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
                            
                            Rectangle()
                                .frame(width: .infinity, height: 1)
                                .foregroundColor(textColor)
                                .padding(.horizontal, 16)
                        }
                        
                        VStack {
                            Button("Log In") {
                                if email.isEmpty || password.isEmpty {
                                    return
                                }
                                
                                signIn()
                            }
                            .foregroundColor(textColor)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(textColor.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: min(screen.size.width * 0.9, 400))
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            userAuthenticated.toggle()
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
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
    SignInView()
}
