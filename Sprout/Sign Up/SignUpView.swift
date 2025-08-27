//
//  SignUpView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/7/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Image("golden-pothos")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 120)
                        .padding(.vertical, 15)
                    
                    VStack(spacing: 24) {
                        InputView(text: $firstName, title: "First Name", placeholder: "Enter first name")
                        
                        InputView(text: $lastName, title: "Last Name", placeholder: "Enter your last name")
                        
                        InputView(text: $email, title: "Email Address", placeholder: "Enter your email")
                            .autocapitalization(.none)
                    
                        InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        
                        ZStack(alignment: .trailing) {
                            InputView(text: $confirmedPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                            
                            if !password.isEmpty && !confirmedPassword.isEmpty {
                                if password == confirmedPassword {
                                    Image(systemName: "checkmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(tabTintColor)
                                }
                                else {
                                    Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemRed))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    Button {
                        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmedPassword.isEmpty {
                            return
                        }
                        
                        if password != confirmedPassword {
                            return
                        }
                        
                        Task {
                            try await viewModel.createUser(withEmail: email, password: password, fullName: firstName + " " + lastName)
                        }
                        
                    } label: {
                        HStack {
                            Text("Create Account").fontWeight(.semibold)
                        }
                        .foregroundColor(backgroundColor)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(textColor)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0:0.5)
                    .cornerRadius(30)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    Button {
                        // action that should happen
                        dismiss()
                    } label: {
                        // this is what the navigation link will look like
                        HStack(spacing: 3) {
                            Text("Already have an account?")
                            Text("Sign In").fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                        .foregroundColor(textColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    var tabTintColor: Color {
         colorScheme == .dark
         ? Color(red: 92/255, green: 157/255, blue: 82/255)
         : Color(red: 48/255, green: 91/255, blue: 38/255)
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

extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && password == confirmedPassword
        && !firstName.isEmpty
        && !lastName.isEmpty
    }
}

#Preview {
    SignUpView()
}
