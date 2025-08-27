//  DistributionCardView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/13/25.

import SwiftUI

struct DistributionCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var distribution: Distribution
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(cardBackgroundColor)
            VStack(spacing: 10) {
                Text(distribution.name)
                Text("TDWG Code: \(distribution.tdwgCode)")
                Text("TDWG Level: \(distribution.tdwgLevel)")
                Text("Species Count: \(distribution.speciesCount)")
            }
            .font(.footnote)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(textColor)
            .padding(8)
        }
        .cornerRadius(15)
    }
    
    private var cardBackgroundColor: Color {
        colorScheme == .light
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
//    DistributionCardView()
//}
