//
//  PlantCardView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/13/25.
//

import SwiftUI

struct PlantCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var plant: PlantSpecies
    @State var showDetail: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                
                Rectangle().background {
                    if let imageURL = plant.imageURL {
                        AsyncImage(url: URL(string: imageURL)) { phase in
                            switch phase {
                            case .empty:
                                Image("golden-pothos")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure:
                                Image("golden-pothos")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            @unknown default:
                                Image("golden-pothos")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    else {
                        Image("golden-pothos")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .foregroundColor(Color.clear)
                
                Text(plant.commonName ?? "Plant Not Found")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(textColor)
            }
        }
        .frame(width: 120, height: 120)
        .cornerRadius(15)
        .onTapGesture {
            showDetail = true
        }
        .fullScreenCover(isPresented: $showDetail) {
            PlantCardDetailView(plantSpecies: plant, showDetail: $showDetail)
        }
    }
    
    private var textColor: Color {
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
    
}

//#Preview {
//    PlantCardView()
//}
