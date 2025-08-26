//  PlantCardDetailView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/13/2025.

import SwiftUI
import SwiftData

struct PlantCardDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @State private var plantImage: Image?
    @State var plantSpecies: PlantData
    @Binding var showDetail:Bool
    private let fallbackImageName = "golden-pothos"
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            screenBackgroundColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                VStack(alignment: .leading) {
                    plantImageView
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    verticallyScrollableView
                    
                    HStack(spacing: 15) {
                        Button {
                            let plant = LocalPlant(name: plantSpecies.commonName!, scientificName: plantSpecies.scientificName, dateSaved: Date(), isVegetable: plantSpecies.vegetable ?? false, plantImageUrl: plantSpecies.imageUrl ?? fallbackImageName, isEdible: plantSpecies.mainSpecies.edible ?? false, foliageTexture: plantSpecies.mainSpecies.foliage.texture ?? "Unknown", leafRetention: plantSpecies.mainSpecies.foliage.leafRetention ?? nil)
                            
                            do {
                                try savePlant(plant, to: context)
                                
                                alertMessage = "Plant saved successfully!"
                                showAlert = true
                            }
                            catch PlantSaveError.duplicateName(let plant_name) {
                                alertMessage = "A plant named '\(plant_name)' already exists"
                                showAlert = true
                            }
                            catch {
                                alertMessage = "Failed to save: \(error.localizedDescription)"
                                showAlert = true
                            }
                            
                            Task {
                                try await Task.sleep(nanoseconds: 2_000_000_000)
                                
                                showDetail = false
                            }
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
                        .alert("Save Result", isPresented: $showAlert) {
                            Button("OK") {}
                        } message: {
                            Text(alertMessage)
                        }
                        
                        
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
    // MARK: - Swift Data
    func savePlant(_ plant: LocalPlant, to modelContext: ModelContext) throws {
        let plantName = plant.name
        
        let fetchDescriptor = FetchDescriptor<LocalPlant>(
            predicate: #Predicate { $0.name == plantName }
        )
        
        let existingPlants = try modelContext.fetch(fetchDescriptor)
        
        if !existingPlants.isEmpty {
            throw PlantSaveError.duplicateName(plant.name)
        }
        
        modelContext.insert(plant)
        try modelContext.save()
    }
    
    // MARK: - Separate Views
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
            Text("Duration: Unknown")
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
    private var flowerView: some View {
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
                        Text("Leaf texture refers to how smooth or rough a plant's leaves and stems appear and has three main categories: fine, medium, and coarse (bold). ")
                    }
                    else {
                        Text("No information on leaf texture for this plant")
                        Text("Leaf texture refers to how smooth or rough a plant's leaves and stems appear and has three main categories: fine, medium, and coarse (bold). ")
                    }
                }
                .foregroundColor(textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                
                
                    if let foliageColors = foliage.color {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Foliage Colors")
                                    .foregroundColor(textColor)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
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
    
    @ViewBuilder
    private var edibleView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let edibility = plantSpecies.mainSpecies.edible {
                Text(edibility ? "Edible: Yes" : "Edible: No")
                    .foregroundColor(textColor)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
            }
            else {
                Text("Edible: Unknown")
                    .foregroundColor(textColor)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
            }
            
            if let edibleParts = plantSpecies.mainSpecies.ediblePart {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Edible Parts")
                    
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(edibleParts, id: \.self) { ediblePart in
                            HStack {
                                Text("•")
                                    .foregroundColor(textColor)
                                    .font(.footnote)
                                
                                Text(ediblePart.capitalizingFirstLetter())
                                    .foregroundColor(textColor)
                                
                                Spacer()
                            }
                            .padding(.leading)
                        }
                    }
                }
            }
            else {
                Text("No edible parts")
                    .foregroundColor(textColor)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    @ViewBuilder
    private var growthView: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            VStack(alignment: .leading, spacing: 4) {
                if plantSpecies.mainSpecies.growth != nil {
                    
                    let growth_object = plantSpecies.mainSpecies.growth
                    
                    if let a_h = growth_object.atmosphericHumidity {
                        Text("Atmospheric Humidity: \(a_h)%")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("Atmospheric Humidity: Unknown")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    
                    if let bloom_months = growth_object.bloomMonths, bloom_months.count > 0 {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Bloom Months")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            ForEach(bloom_months, id: \.self) { bloom_month in
                                HStack(alignment: .top) {
                                    Text("•")
                                        .foregroundColor(textColor)
                                        .font(.footnote)
                                    
                                    Text(bloom_month.capitalizingFirstLetter())
                                        .foregroundColor(textColor)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 16)
                            }
                        }
                    }
                    else {
                        Text("There are no months for which this species usually blooms")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if let daysToHarvest = growth_object.daysToHarvest {
                        Text("Days to Harvest: \(daysToHarvest) days")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("Days to Harvest: Unknown")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        
                        Text("Days to Harvest is the average numbers of days required to from planting to harvest")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                                        
                    if let growth_desc = growth_object.description {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Growth Description:")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(growth_desc)
                                    .foregroundColor(textColor)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 16)
                            }
                        }
                    }
                    else {
                        Text("No growth description to report for this plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // plantSpecies.mainSpecies.growth.fruitMonths // [String]?
                    // plantSpecies.mainSpecies.growth.growthMonths // [String]?
                    
                    if let fruitMonths = growth_object.fruitMonths {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Fruit Months")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            ForEach(fruitMonths, id: \.self) { fruitMonth in
                                HStack(alignment: .top) {
                                    Text("•")
                                        .foregroundColor(textColor)
                                        .font(.footnote)
                                    
                                    Text(fruitMonth.capitalizingFirstLetter())
                                        .foregroundColor(textColor)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 16)
                            }
                        }
                    }
                    else {
                        Text("There are no months this species usually produces fruits")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if let growthMonths = growth_object.growthMonths {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Growth Months")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            ForEach(growthMonths, id: \.self) { growthMonth in
                                HStack(alignment: .top) {
                                    Text("•")
                                        .foregroundColor(textColor)
                                        .font(.footnote)
                                    
                                    Text(growthMonth.capitalizingFirstLetter())
                                        .foregroundColor(textColor)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 16)
                            }
                        }
                    }
                    else {
                        Text("There are no active growth months for this species")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    
                    if let light = growth_object.light {
                        Text("Required Light: \(light) lux")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on required light for this plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        
                        Text("Required amount of light, on a scale from 0 (no light, <= 10 lux) to 10 (very intensive insolation, >= 100 000 lux)")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Maximum Precipitation
                    if growth_object.maximumPrecipitation != nil {
                        if growth_object.maximumPrecipitation.cm != nil && growth_object.maximumPrecipitation.mm != nil {
                            Text("Annual Maximum Precipitation: \(growth_object.maximumPrecipitation.cm) cm or \(growth_object.maximumPrecipitation.mm) mm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.maximumPrecipitation.cm != nil {
                            Text("Annual Maximum Precipitation: \(growth_object.maximumPrecipitation.cm) cm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.maximumPrecipitation.mm != nil {
                            Text("Annual Maximum Precipitation: \(growth_object.maximumPrecipitation.mm) mm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else {
                            Text("No information on maximum annual precipitation for this plant")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    else {
                        Text("No information on maximum annual precipitation for this plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Maximum Temperature
                    if growth_object.maximumTemperature != nil {
                        if growth_object.maximumTemperature.degC != nil && growth_object.maximumTemperature.degF != nil {
                            Text("Maximum Temperature: \(growth_object.maximumTemperature.degC)°C/\(growth_object.maximumTemperature.degF)°F")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.maximumTemperature.degC != nil {
                            Text("Maximum Temperature: \(growth_object.maximumTemperature.degC)°C")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.maximumTemperature.degF != nil {
                            Text("Maximum Temperature: \(growth_object.maximumTemperature.degF)°F")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else {
                            Text("No information on maximum tolerable temperature for this species of plant")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    else {
                        Text("No information on maximum tolerable temperature for this species of plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Minimum Precipitation
                    if growth_object.minimumPrecipitation != nil {
                        if growth_object.minimumPrecipitation.cm != nil && growth_object.minimumPrecipitation.mm != nil {
                            Text("Annual Minimum Precipitation: \(growth_object.minimumPrecipitation.cm) cm or \(growth_object.minimumPrecipitation.mm) mm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.minimumPrecipitation.cm != nil {
                            Text("Annual Minimum Precipitation: \(growth_object.minimumPrecipitation.cm) cm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.minimumPrecipitation.mm != nil {
                            Text("Annual Minimum Precipitation: \(growth_object.minimumPrecipitation.mm) mm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else {
                            Text("No information on minimum annual precipitation, in milimeters")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    else {
                        Text("No information on minimum annual precipitation, in milimeters per year")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Minimum Root Depth
                    if growth_object.minimumRootDepth != nil {
                        if growth_object.minimumRootDepth.cm != nil && growth_object.minimumRootDepth.mm != nil {
                            Text("Minimum Root Depth: \(growth_object.minimumRootDepth.cm) cm/\(growth_object.minimumRootDepth.mm) mm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.minimumRootDepth.cm != nil {
                            Text("Minimum Root Depth: \(growth_object.minimumRootDepth.cm) cm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.minimumRootDepth.mm != nil {
                            Text("Minimum Root Depth: \(growth_object.minimumRootDepth.mm) mm")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else {
                            Text("No information on minimum soil depth required by the species, in cm. Rootless plants have soil depth of 0.")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    else {
                        Text("No information on minimum soil depth required by the species, in cm. Rootless plants have soil depth of 0.")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Minimum Temperature
                    if growth_object.minimumTemperature != nil {
                        if growth_object.minimumTemperature.degC != nil && growth_object.minimumTemperature.degF != nil {
                            Text("Minimum Temperature: \(growth_object.minimumTemperature.degC)°C/\(growth_object.minimumTemperature.degF)°F")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.minimumTemperature.degC != nil {
                            Text("Minimum Temperature: \(growth_object.minimumTemperature.degC)°C")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else if growth_object.minimumTemperature.degF != nil {
                            Text("Minimum Temperature: \(growth_object.minimumTemperature.degF)°F")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                        else {
                            Text("No information on minimum tolerable temperature for this species of plant")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    else {
                        Text("No information on minimum tolerable temperature for this species of plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - PH Maximum
                    if growth_object.phMaximum != nil {
                        
                        let originalValue = growth_object.phMaximum!
                        let formattedString = String(format: "%.1f", originalValue)
                        
                        Text("PH Maximum: \(formattedString) pH")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on maximum acceptable soil pH (of the top 30 cm of soil) for the plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - PH Minimum
                    if growth_object.phMinimum != nil {
                        let originalValue = growth_object.phMinimum!
                        let formattedString = String(format: "%.1f", originalValue)
                        
                        Text("PH Minimum: \(formattedString) pH")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on minimum acceptable soil pH (of the top 30 cm of soil) for the plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    
                    // MARK: - Row Spacing - The minimum spacing between each rows of plants, in centimeters
                    if growth_object.rowSpacing.cm != nil && growth_object.rowSpacing.mm != nil {
                        let rowSpacingCM = growth_object.rowSpacing.cm!
                        let formattedCM = String(format: "%.1f", rowSpacingCM)
                        
                        let rowSpacingMM = growth_object.rowSpacing.mm!
                        let formattedMM = String(format: "%.1f", rowSpacingMM)
                        
                        Text("Row Spacing: \(formattedCM) cm/\(formattedMM) mm")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else if growth_object.rowSpacing.cm != nil {
                        let rowSpacingCM = growth_object.rowSpacing.cm!
                        let formattedCM = String(format: "%.1f", rowSpacingCM)
                        
                        Text("Row Spacing: \(formattedCM) cm")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else if growth_object.rowSpacing.mm != nil {
                        let rowSpacingMM = growth_object.rowSpacing.mm!
                        let formattedMM = String(format: "%.1f", rowSpacingMM)
                        
                        Text("Row Spacing: \(formattedMM) mm")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on minimum spacing between each row of plants")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // plantSpecies.mainSpecies.growth.soilNutriments // Int?
                    // plantSpecies.mainSpecies.growth.soilSalinity // Int?
                    // plantSpecies.mainSpecies.growth.soilTexture // Int?
                    // plantSpecies.mainSpecies.growth.sowing // String?
                    // plantSpecies.mainSpecies.growth.spread // Distance
                    
                    // MARK: - Soil Humidity
                    if growth_object.soilHumidity != nil {
                        Text("Required Soil Humidity: \(growth_object.soilHumidity!)")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on the required plant soil humidity [0 (xerophile) - 10 (subaquatic)]")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Soil Nutriments
                    if growth_object.soilNutriments != nil {
                        Text("Required Soil Nutriment Quantity: \(growth_object.soilNutriments!)")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on the required quantity of soil nutriments [0 (oligotrophic) - 10 (hypereutrophic)]")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Soil Salinity
                    if growth_object.soilSalinity != nil {
                        Text("Required Soil Salinity: \(growth_object.soilSalinity!)")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on the salinity tolerance [0 (untolerant) - 10 (hyperhaline)]")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Soil Texture
                    if growth_object.soilTexture != nil {
                        Text("Required Soil Texture: \(growth_object.soilTexture!)")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information on the required soil texture [0 (clay) - 10 (rock)]")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Sowing
                    if growth_object.sowing != nil {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sowing Description")
                                .foregroundColor(textColor)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(growth_object.sowing!)
                                    .foregroundColor(textColor)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.leading, 16)
                        }
                    }
                    else {
                        Text("No description on sowing the plant")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // MARK: - Spread
                    if growth_object.spread.cm != nil && growth_object.spread.mm != nil {
                        let originalCM = growth_object.spread.cm!
                        let originalMM = growth_object.spread.mm!
                        
                        let formattedCM = String(format: "%.1f", originalCM)
                        let formattedMM = String(format: "%.1f", originalMM)
                        
                        Text("Spread: \(formattedCM) cm/\(formattedMM) mm")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else if growth_object.spread.cm != nil {
                        let originalCM = growth_object.spread.cm!
                        let formattedCM = String(format: "%.1f", originalCM)
                        
                        Text("Spread: \(formattedCM) cm")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else if growth_object.spread.mm != nil {
                        let originalMM = growth_object.spread.mm!
                        let formattedMM = String(format: "%.1f", originalMM)
                        
                        Text("Spread: \(formattedMM) mm")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("No information to display on the average spreading of the plant, in centimeters")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
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
        
            
            VStack(alignment: .leading, spacing: 8) {
                
                if specifications.averageHeight != nil {
                    if specifications.averageHeight.cm != nil {
                        Text("Average Height: \(specifications.averageHeight.cm) cm")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("Average Height: Unknown")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                }
                else {
                    Text("No height to report on this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                if let growth_form = specifications.growthForm {
                    Text("Growth Form: \(growth_form.capitalizingFirstLetter())")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No growth form to report on this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                // MARK: - Growth Habit
                if let growth_habit = specifications.growthHabit {
                    Text("Growth Habit: \(growth_habit.capitalizingFirstLetter())")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No growth habits to report for this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                // MARK: - Growth Rate
                if let growth_rate = specifications.growthRate {
                    Text("Growth Rate: \(growth_rate.capitalizingFirstLetter())")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No growth rate to report for this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                // MARK: - Ligneous Type
                if let ligneous_type = specifications.ligneousType {
                    Text("Ligenous Type: \(ligneous_type.capitalizingFirstLetter())")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No ligneous type to report for this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                // MARK: - Maximum Height
                if specifications.maximumHeight != nil {
                    if let height_length = specifications.maximumHeight.cm {
                        Text("Maximum Height: \(height_length)")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    else {
                        Text("Maximum Height: Unknown")
                            .foregroundColor(textColor)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                }
                else {
                    Text("No maximum height to report for this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                // specifications.ligneousType // String?
                // specifications.maximumHeight // Height
                // specifications.nitrogenFixation // String?
                
                // specifications.shapeAndOrientation // String?
                // specifications.toxicity // String?
                
                // MARK: - Nitrogen Fixation
                if let nitrogen_fixation = specifications.nitrogenFixation {
                    Text("Nitrogen Fixation: \(nitrogen_fixation.capitalizingFirstLetter())")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No nitrogen fixation to report for this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                
                // MARK: - Shape and Orientation
                if let shape_and_orientation = specifications.shapeAndOrientation {
                    Text("Shape and Orientation: \(shape_and_orientation.capitalizingFirstLetter())")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No shape and orientation to report for this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                // MARK: - Toxicity
                if let toxicity = specifications.toxicity {
                    Text("Toxicity Level: \(toxicity.capitalizingFirstLetter())")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("No toxicity levels to report for this plant.")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                
            }
            
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
            VStack(alignment: .leading, spacing: 25) {
                Text(plantSpecies.commonName ?? "")
                    .foregroundColor(textColor)
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(plantSpecies.scientificName)
                       
                    Text("Observations: \(plantSpecies.observations)")
                }
                .foregroundColor(textColor)
                .font(.title2)
                .fontWeight(.bold)
                
                edibleView
                
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
                        // .aspectRatio(contentMode: .fit)
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
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
//                .onAppear {
//                    plantImage = image
//                }
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
//            .onAppear {
//                plantImage = Image(fallbackImageName)
//            }
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
