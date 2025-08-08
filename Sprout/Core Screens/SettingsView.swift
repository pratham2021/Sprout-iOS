//
//  SettingsView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: AuthViewModel
    
    let firstSectionTitle = "Settings"
    let secondSectionTitle = "Account"
    
    var body: some View {
        if let user = viewModel.currentUser {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                List {
                    Text(firstSectionTitle.prefix(1).uppercased() + firstSectionTitle.dropFirst().lowercased())
                        .foregroundColor(textColor)
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Section(header: EmptyView()) {
                        HStack {
                            Text("\(user.initials)")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(backgroundColor)
                                .frame(width: 72, height: 72)
                                .background(textColor)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(user.fullName)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(textColor)
                                    .padding(.top, 4)
                                
                                Text("\(user.email)")
                                    .font(.footnote)
                                    .accentColor(textColor)
                            }
                        }
                    }
                    .listRowBackground(sectionColor)
                    .cornerRadius(15)
                    
                    Text(secondSectionTitle.prefix(1).uppercased() + secondSectionTitle.dropFirst().lowercased())
                        .foregroundColor(textColor)
                        .font(.headline)
                    
                    Section(header: EmptyView()) {
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingsRowView(imageName: "arrow.left.square.fill", title: "Sign Out", tintColor: textColor)
                        }
                        
                        Button {
                            viewModel.deleteAccount()
                        } label: {
                            SettingsRowView(imageName: "minus.circle.fill", title: "Delete Account", tintColor: textColor)
                        }
                    }
                    .listRowBackground(sectionColor)
                    .cornerRadius(15)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
        }

    }
    
    private var sectionColor: Color {
        colorScheme == .light
        ? Color(red: 250/255, green: 187/255, blue: 139/255)
        : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var tintColor: Color {
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

#Preview {
    SettingsView()
}
