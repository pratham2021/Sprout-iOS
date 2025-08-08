//
//  SettingsRowView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/7/25.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
                
            Text(title)
                .font(.subheadline)
                .foregroundColor(tintColor)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
