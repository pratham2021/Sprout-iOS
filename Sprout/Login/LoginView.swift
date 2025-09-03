//
//  LoginView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/3/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
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
                            InputView(text: $email, title: "Email Address", placeholder: "Enter your email")
                                .autocapitalization(.none)
                            
                            InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                        
                        Button {
                            
                            if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                                
                                isShowingAlert = true
                                
                                var errorString = ""
                                
                                if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                                    errorString += "Email Field can't be blank."
                                }
                                
                                if password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                                    errorString += "\n"
                                    errorString += "Password field can't be blank."
                                }
                                
                                alertMessage = errorString
                                
                                return
                            }
                            
                            Task {
                                do {
                                    try await viewModel.signIn(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines))
                                    
                                    isShowingAlert = false
                                }
                                catch {
                                    isShowingAlert = true
                                    alertMessage = "The app failed to sign you in! Perhaps the user does not have an account."
                                }
                            }
                        } label: {
                            HStack {
                                Text("Sign In").fontWeight(.semibold)
                            }
                            .foregroundColor(backgroundColor)
                            .frame(maxWidth: .infinity, minHeight: 48)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(textColor)
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        .cornerRadius(30)
                        .padding(.top, 12)
                        .padding(.horizontal, 30)
                        
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
                        .buttonStyle(PlainButtonStyle())
                        
                        
                    }
                }
                
            }
            .alert("Error", isPresented: $isShowingAlert) {
                Button("Try Again", role: .cancel) {}
            } message: {
                Text(verbatim: alertMessage)
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
    
extension LoginView: AuthenticationFormProtocol {
        var formIsValid: Bool {
            return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
        }
    }

//#Preview {
//    LoginView()
//}
