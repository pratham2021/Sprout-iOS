//  PlantCardDetailView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/13/2025.

import SwiftUI

struct PlantCardDetailView: View {
    
    @State var plantSpecies: PlantSpecies
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
//    PlantCardDetailView()
//}
