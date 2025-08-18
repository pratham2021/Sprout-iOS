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
                        
                        VStack(alignment: .leading, spacing: 4) {
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
        if plantSpecies.mainSpecies.distributions != nil {
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
        
        
        var new_string = ""
        
        if plantSpecies.mainSpecies.flower != nil {
            
            let flower = plantSpecies.mainSpecies.flower
            
            VStack(alignment: .leading, spacing: 8) {
                
                if flower.conspicuous == nil {
                    Text("No information on visual conspicuousness for this flower")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    Text("Inconspicous flowers are flowers that tend not to draw attention. These flowers are either small, have dull colors, or mild in fragrance.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    if flower.conspicuous! {
                        Text("This plant has a conspicous flower")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("This plant has an inconspicous flower")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        
                        Text("Inconspicous flowers are flowers that tend not to draw attention. These flowers are either small, have dull colors, or mild in fragrance.")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                if flower.color?.count == 0 || flower.color == nil {
                    Text("No flower colors")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    let colors = flower.color!
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Flower Colors")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(colors, id: \.self) { flowerColor in
                                HStack {
                                    Text("•")
                                        .foregroundColor(textColor)
                                        .font(.footnote)
                                    
                                    Text(flowerColor.capitalizingFirstLetter())
                                        .foregroundColor(textColor)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 16)
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    @ViewBuilder
    private var foliageView: some View {
        
        if plantSpecies.mainSpecies.foliage != nil {
            
            
            VStack(alignment: .leading, spacing: 8) {
                let foliage = plantSpecies.mainSpecies.foliage
                
                VStack(alignment: .leading, spacing: 8) {
                    if let leafRetention = foliage.leafRetention {
                        Text("Leaf Retention: \(leafRetention)")
                        Text("Leaf retention (or marcescence) is the ability of a deciduous tree to retain dead leaves in the winter months, past the leaf-drop period, which is typically in fall.")
                    }
                    else {
                        Text("No information on leaf retention for this plant")
                        Text("Leaf retention (or marcescence) is the ability of a deciduous tree to retain dead leaves in the winter months, past the leaf-drop period, which is typically in fall.")
                    }
                }
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    if let texture = foliage.texture {
                        Text("Leaf Texture: \(texture.capitalizingFirstLetter())")
                        //                            .foregroundColor(textColor)
                        //                            .font(.subheadline)
                        //                            .fontWeight(.semibold)
                        //                            .multilineTextAlignment(.leading)
                        
                        Text("Leaf texture refers to the smoothness or roughness of a plant's leaves and stems based on appearance and has three main umbrellas: fine, medium, and coarse (bold). ")
                        //                            .foregroundColor(textColor)
                        //                            .font(.subheadline)
                        //                            .fontWeight(.semibold)
                        //                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on leaf texture for this plant")
                        //                            .foregroundColor(textColor)
                        //                            .font(.subheadline)
                        //                            .fontWeight(.semibold)
                        //                            .multilineTextAlignment(.leading)
                        
                        Text("Leaf texture refers to the smoothness or roughness of a plant's leaves and stems based on appearance and has three main umbrellas: fine, medium, and coarse (bold). ")
                        //                            .foregroundColor(textColor)
                        //                            .font(.subheadline)
                        //                            .fontWeight(.semibold)
                        //                            .multilineTextAlignment(.leading)
                    }
                }
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                
                //                HStack(alignment: .top) {
                //                    Text("•")
                //                        .foregroundColor(textColor)
                //                        .font(.footnote)
                //
                //                    Text(plantName)
                //                        .foregroundColor(textColor)
                //                        .font(.footnote)
                //                        .multilineTextAlignment(.leading)
                //
                //                    Spacer()
                //                }
                //                .padding(.leading, 16)
                
                VStack(alignment: .leading, spacing: 4) {
                    if let foliageColors = foliage.color {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(foliageColors, id: \.self) { randomColor in
                                HStack(alignment: .top) {
                                    Text("•")
                                        .foregroundColor(textColor)
                                        .font(.footnote)
                                    
                                    Text(randomColor)
                                        .foregroundColor(textColor)
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 16)
                            }
                        }
                    }
                    else {
                        Text("No foliage colors for this plant.")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                }
                
            }
            
        }
        
    }
    
//    let id: Int
//    let commonName: String?
//    let slug: String
//    let scientificName: String
//   
//    let year: Int?
//    let status: String?
//    
//    let edible: Bool?
//    let ediblePart: [String]?
//    let duration: [String]?
//    
//    let images: Images
//    let commonNames: [String: [String]]
//    let distribution: [String: [String]]
//    let distributions: SpeciesDistributions
//    let flower: FlowerInfo
//    let foliage: FoliageInfo
//    let fruitOrSeed: FruitOrSeedInfo
//    let specifications: Specifications
//    let growth: Growth
    
//    VStack(alignment: .leading, spacing: 8) {
//        ForEach(sortedDistribution, id: \.key) { section_name in
//            VStack(alignment: .leading, spacing: 4) {
//                Text(section_name.key.capitalizingFirstLetter())
//                    .foregroundColor(textColor)
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                
//                VStack(alignment: .leading, spacing: 4) {
//                    ForEach(section_name.value, id: \.self) { value in
//                        HStack(alignment: .top) {
//                            Text("•")
//                                .foregroundColor(textColor)
//                                .font(.footnote)
//                            
//                            Text(value)
//                                .foregroundColor(textColor)
//                                .font(.footnote)
//                                .multilineTextAlignment(.leading)
//                            
//                            Spacer()
//                        }
//                        .padding(.leading, 16)
//                    }
//                }
//            }
//        }
//    }
    
    @ViewBuilder
    private var growthView: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            VStack(alignment: .leading, spacing: 4) {
                if plantSpecies.mainSpecies.growth != nil {
                    
//                    plantSpecies.mainSpecies.growth.atmosphericHumidity // Int?
//                    plantSpecies.mainSpecies.growth.bloomMonths // [String]?
//                    plantSpecies.mainSpecies.growth.daysToHarvest // Double?
//                    plantSpecies.mainSpecies.growth.description // String?
//                    plantSpecies.mainSpecies.growth.fruitMonths // [String]?
//                    plantSpecies.mainSpecies.growth.growthMonths // [String]?
//                    plantSpecies.mainSpecies.growth.light // Int?
//                    plantSpecies.mainSpecies.growth.maximumPrecipitation // Distance
//                    plantSpecies.mainSpecies.growth.maximumTemperature // Temperature
//                    plantSpecies.mainSpecies.growth.minimumPrecipitation // Distance
//                    plantSpecies.mainSpecies.growth.minimumRootDepth // Distance
//                    plantSpecies.mainSpecies.growth.minimumTemperature // Temperature
//                    plantSpecies.mainSpecies.growth.phMaximum // Double?
//                    plantSpecies.mainSpecies.growth.phMinimum // Double?
//                    plantSpecies.mainSpecies.growth.rowSpacing // Distance
//                    plantSpeices.mainSpecies.growth.soilHumidity // Int?
//                    plantSpecies.mainSpecies.growth.soilNutriments // Int?
//                    plantSpecies.mainSpecies.growth.soilSalinity // Int?
//                    plantSpecies.mainSpecies.growth.soilTexture // Int?
//                    plantSpecies.mainSpecies.growth.sowing // String?
//                    plantSpecies.mainSpecies.growth.spread // Distance
                    
                    Text("Growth Details")
                }
                else {
                    Text("No information to display for plant growth")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
    
    @ViewBuilder
    private var specificationsView: some View {
        if plantSpecies.mainSpecies.specifications != nil {
            let specifications = plantSpecies.mainSpecies.specifications
            
            // specifications.averageHeight // Height
                // specifications.averageHeight.cm // Int?
            
            // specifications.growthForm // String?
            // specifications.growthHabit // String?
            // specifications.growthRate // String?
            
            // specifications.ligneousType // String?
            // specifications.maximumHeight // Height
            // specifications.nitrogenFixation // String?
            
            // specifications.shapeAndOrientation // String?
            // specifications.toxicity // String?
            
            Text("Specifications View")
        }
    }
    
    
    @ViewBuilder
    private var fruitOrSeedView: some View {
        if plantSpecies.mainSpecies.fruitOrSeed != nil {
            let fruitOrSeed = plantSpecies.mainSpecies.fruitOrSeed
            
            VStack(alignment: .leading, spacing: 8) {
                
                if let fruitColors = fruitOrSeed.color {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Fruit Colors")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(fruitColors, id: \.self) { fruitColor in
                                HStack {
                                    Text("•")
                                        .foregroundColor(textColor)
                                        .font(.footnote)
                                    
                                    Text(fruitColor.capitalizingFirstLetter())
                                        .foregroundColor(textColor)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 16)
                            }
                        }
                    }
                }
                else {
                    Text("No Fruit Colors")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                if fruitOrSeed.conspicuous != nil {
                    Text(fruitOrSeed.conspicuous! ? "Fruit Conspicuousness: Visible" : "Fruit Conspicuousness: Invisible")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No information on fruit visibility.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                if fruitOrSeed.seedPersistence != nil {
                    Text(fruitOrSeed.conspicuous! ? "Fruit Conspicuousness: Visible" : "Fruit Conspicuousness: Invisible")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No information on fruit seed persistence.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    Text("Seed persistence is a plant's ability for its fruits or seed considered persistent in the soil for long periods of time.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                if fruitOrSeed.shape != nil {
                    Text("Fruit Shape: \(fruitOrSeed.shape!)")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No information on fruit's shape")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
            }
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
            VStack(alignment: .leading, spacing: 35) {
                Text(plantSpecies.commonName ?? "")
                    .foregroundColor(textColor)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(plantSpecies.scientificName)
                    .foregroundColor(textColor)
                    .font(.footnote)
                    .fontWeight(.bold)
                
                // edibleView
                
                commonNamesView
                
                distributionView
                
                durationSection
                
                flowerView
                
                foliageView
                
                fruitOrSeedView
                
                growthView
                
                specificationsView
                
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
