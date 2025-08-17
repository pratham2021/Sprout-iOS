//  PlantCardDetailView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/13/2025.

import SwiftUI

struct PlantCardDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var plantImage: Image?
    @State var plantSpecies: PlantData
    @Binding var showDetail:Bool
    private let fallbackImageName = "golden-pothos"
    
    var body: some View {
        ZStack {
            screenBackgroundColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                plantImageView
                
                VStack(alignment: .leading) {
                    
                    verticallyScrollableView
                    
                    HStack(spacing: 15) {
                        Button {
                            // save to local on device storage
                            
                            // if it already exists, throw an error
                            
                            // if it doesn't already exist, then save it locally on device
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(buttonBackgroundColor)
                                    .frame(height: 40)
                                
                                Text("Save locally")
                                    .foregroundColor(cardBackgroundColor)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            showDetail = false
                        }
                        label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(textColor)
                                    .frame(height: 40)
                                
                                Text("Dismiss")
                                    .foregroundColor(cardBackgroundColor)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
    
    @ViewBuilder
    private var commonNamesView: some View {
        if plantSpecies.mainSpecies.commonNames.count > 0 {
            let sortedCommonNames = plantSpecies.mainSpecies.commonNames.filter { $0.key.count < 3 }.sorted { $0.key < $1.key }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(sortedCommonNames, id: \.key) { language in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(language.key.capitalizingFirstLetter())
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        ForEach(language.value, id: \.self) { plantName in
//                            Text("• \(plantName)")
                            HStack(alignment: .top) {
                                Text("•")
                                    .foregroundColor(textColor)
                                    .font(.footnote)
                                
                                Text(plantName)
                                    .foregroundColor(textColor)
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.leading, 16)
                        }
                    }
                    
                }
            }
        }
        else {
            Text("No common names")
                .foregroundColor(textColor)
                .font(.footnote)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    private var durationSection: some View {
        if let duration = plantSpecies.mainSpecies.duration {
            HStack {
                ForEach(duration, id: \.self) { durationItem in
                    Text(durationItem)
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        else {
            Text("Unknown Duration")
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    private var distributionView: some View {
        if plantSpecies.mainSpecies.distribution.count > 0 {
            let sortedDistribution = plantSpecies.mainSpecies.distribution.sorted { $0.key < $1.key }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(sortedDistribution, id: \.key) { section_name in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(section_name.key.capitalizingFirstLetter())
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        ForEach(section_name.value, id: \.self) { value in
                            HStack(alignment: .top) {
                                Text("•")
                                    .foregroundColor(textColor)
                                    .font(.footnote)
                                
                                Text(value)
                                    .foregroundColor(textColor)
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.leading, 16)
                        }
                    }
                }
            }
        }
        else {
            Text("No distributions to show")
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    private var distributionsView: some View {
        if let distributions = plantSpecies.mainSpecies.distributions {
            Text("Distribution zones!")
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
        }
        else {
            Text("No distribution zones to show")
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
        }
    }
    
//    "flower": {
//        "color": null,
//        "conspicuous": null
//    },
//    "foliage": {
//        "texture": null,
//        "color": null,
//        "leaf_retention": null
//    },
//    "fruit_or_seed": {
//        "conspicuous": null,
//        "color": null,
//        "shape": null,
//        "seed_persistence": null
//    },
    
    @ViewBuilder
    private var flowerView: some View {
//        var new_string = ""
//        if let flower = plantSpecies.mainSpecies.flower {
//            
//            if flower.color == nil {
//                new_string += "No Color"
//            }
//            else {
//                ForEach(flower.color, id: \.self) { color in
//                    new_string += "\(color)"
//                }
//            }
//            
//            if flower.conspicuous {
//                new_string
//            }
//        }
//        
//        Text(new_string)
//            .
        
        if let flower = plantSpecies.mainSpecies.flower {
            
        }
    }
    
    @ViewBuilder
    private var foliageView: some View {
        if let foliage = plantSpecies.mainSpecies.foliage {
            
        }
    }
    
    @ViewBuilder
    private var vegetableLabel: some View {
        if let vegetable = plantSpecies.vegetable {
            Text(vegetable ? "Vegetable: Yes" : "Vegetable: No")
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
        }
        
    }
    
    @ViewBuilder
    private var verticallyScrollableView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text(plantSpecies.commonName ?? "")
                    .foregroundColor(textColor)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(plantSpecies.scientificName)
                    .foregroundColor(textColor)
                    .font(.footnote)
                    .fontWeight(.bold)
                
                commonNamesView
                
                distributionView
                
                durationSection
                
                vegetableLabel
            }
        }
    }
    
    @ViewBuilder
    private var plantImageView: some View {
        Group {
            if let imageURL = plantSpecies.imageUrl {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    asyncImageContent(for: phase)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Rectangle())
                }
            } else {
                fallbackImage
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
            }
        }
    }
    
    @ViewBuilder
    private func asyncImageContent(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            fallbackImage
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .onAppear {
                    plantImage = image
                }
        case .failure:
            fallbackImage
        @unknown default:
            fallbackImage
        }
    }
        
    private var fallbackImage: some View {
        Image(fallbackImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
            .onAppear {
                plantImage = Image(fallbackImageName)
            }
    }
    
    private var buttonBackgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 68/255, green: 123/255, blue: 59/255)
            : Color(red: 48/255, green: 91/255, blue: 38/255)
    }
    
    private var screenBackgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 250/255, green: 187/255, blue: 139/255)
            : Color(red: 244/255, green: 218/255, blue: 198/255)
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
