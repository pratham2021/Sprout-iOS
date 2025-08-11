//
//  APITestView.swift
//  Sprout
//
//  Created by Caden Matuszewicz on 8/10/25.
//

import SwiftUI

struct TestView: View {
    @State private var plants: [Plant] = []
    
    var body: some View {
        List(plants, id: \.id) { plant in
            VStack(alignment: .leading) {
                Text(plant.commonName ?? "Unknown")
                    .font(.headline)
                Text(plant.scientificName?.joined(separator: ", ") ?? "")
                    .font(.subheadline)
            }
        }
        .task {
            await fetchSpecies { fetched in
                plants = fetched
            }
        }
    }
}

#Preview {
    TestView()
}
