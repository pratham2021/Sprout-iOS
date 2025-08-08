//
//  LoginView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/7/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack {
                    Image("golden-pothos")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 120)
                        .padding(.vertical, 15)
                    
                    VStack(spacing: 24) {
                        InputView(text: $email, title: "Email Address", placeholder: "Enter your email")
                            .autocapitalization(.none)
                    
                        InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    Button {
                        print("Sign In the User!")
                    } label: {
                        HStack {
                            Text("Sign In").fontWeight(.semibold)
                        }
                        .foregroundColor(backgroundColor)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                    }
                    .background(textColor)
                    .cornerRadius(30)
                    .padding(.horizontal)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUpView().navigationBarBackButtonHidden(true)
                    } label: {
                        // this is what the navigation link will look like
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Create Account").fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                        .foregroundColor(textColor)
                    }
                    
                }
                
            }
            
        }
        .tint(textColor)
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
    LoginView()
}
