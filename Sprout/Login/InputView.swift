//
//  InputView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/3/25.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(textColor)
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.horizontal, 16)
            
            
            if isSecureField {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(textColor))
                    .font(.system(size: 14))
                    .tint(textColor)
                    .foregroundColor(textColor)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
            } else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(textColor))
                    .font(.system(size: 14))
                    .tint(textColor)
                    .foregroundColor(textColor)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
            }
            
            Rectangle().frame(height: 1).foregroundColor(textColor).padding(.horizontal, 16)
        }
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark
        ? Color(red: 250/255, green: 187/255, blue: 139/255)
        : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark
        ? Color(red: 0.2, green: 0.15, blue: 0.1)
        : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "Email Address")
}
