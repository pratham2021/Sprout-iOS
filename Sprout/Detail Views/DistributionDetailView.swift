//
//  DistributionDetailView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/13/25.
//

import SwiftUI

struct DistributionDetailView: View {
    
    @State var distribution: Distribution
    @Binding var showDetail:Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("This is another view")
                .font(.title)

            Button("Dismiss") {
                showDetail = false
            }
        }
        .padding()
    }
}

//#Preview {
//    DistributionDetailView()
//}
