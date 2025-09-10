//
//  SettingsView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/3/25.
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
                    Section(header: Text(firstSectionTitle.prefix(1).uppercased() + firstSectionTitle.dropFirst().lowercased()).foregroundColor(textColor).font(.headline)) {
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
                                    .foregroundColor(textColor)
                            }
                        }
                    }
                    .listRowBackground(sectionColor)
                    .cornerRadius(15)
                    
                    Section(header: Text(secondSectionTitle.prefix(1).uppercased() + secondSectionTitle.dropFirst().lowercased()).foregroundColor(textColor).font(.headline)) {
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
        else {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                List {
                    
                    Section(header: Text(firstSectionTitle.prefix(1).uppercased() + firstSectionTitle.dropFirst().lowercased())
                            .foregroundColor(textColor)
                            .font(.headline)
                    ) {
                        HStack {
                            Text("PH")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(backgroundColor)
                                .frame(width: 72, height: 72)
                                .background(textColor)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Pratham Hebbar")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(textColor)
                                    .padding(.top, 4)
                                
                                Text("prathamhebbar2021@gmail.com")
                                    .font(.footnote)
                                    .foregroundColor(textColor)
                            }
                        }
                    }
                    .listRowBackground(sectionColor)
                    .cornerRadius(15)
                    
                    Section(header: Text(secondSectionTitle.prefix(1).uppercased() + secondSectionTitle.dropFirst().lowercased())
                            .foregroundColor(textColor)
                            .font(.headline)
                    ) {
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

//#Preview {
//    SettingsView(viewModel: AuthViewModel())
//}
