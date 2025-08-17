//  PlantCardView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/13/2025

import SwiftUI

struct PlantCardView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var plant: PlantSpecies
    
    @State private var plantImage: Image?
    @State private var showDetail = false
    @State private var plantToDisplayInDetail: PlantData?
    @State private var isLoading = false
    
    private let cardSize: CGFloat = 120
    private let cornerRadius: CGFloat = 15
    private let spacing: CGFloat = 15
    private let fallbackImageName = "golden-pothos"
    
    var body: some View {
        VStack(spacing: spacing) {
            plantImageView
            plantNameText
        }
        .frame(width: cardSize, height: cardSize)
//        .background(cardBackgroundColor)
        .cornerRadius(cornerRadius)
        .task {
            await loadPlantDetails()
        }
        .onTapGesture {
            handleTap()
        }
        .fullScreenCover(isPresented: $showDetail) {
            plantDetailView
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var plantImageView: some View {
        Group {
            if let imageURL = plant.imageURL {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    asyncImageContent(for: phase)
                }
            } else {
                fallbackImage
            }
        }
        .aspectRatio(contentMode: .fit)
        .clipShape(Rectangle())
    }
    
    @ViewBuilder
    private func asyncImageContent(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            fallbackImageWithLoading
        case .success(let image):
            image
                .resizable()
                .onAppear { plantImage = image }
        case .failure:
            fallbackImage
        @unknown default:
            fallbackImage
        }
    }
    
    private var fallbackImage: some View {
        Image(fallbackImageName)
            .resizable()
            .onAppear {
                plantImage = Image(fallbackImageName)
            }
    }
    
    private var fallbackImageWithLoading: some View {
        ZStack {
            fallbackImage
            if isLoading {
                ProgressView()
                    .scaleEffect(0.8)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
            }
        }
    }
    
    private var plantNameText: some View {
        Text(plant.commonName ?? "Plant Not Found")
            .font(.footnote)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(textColor)
    }
    
    @ViewBuilder
    private var plantDetailView: some View {
        if let plantData = plantToDisplayInDetail, let image = plantImage {
            PlantCardDetailView(plantSpecies: plantData, image: plantImage!, showDetail: $showDetail)
        } else {
            loadingView
        }
    }
    
    private var loadingView: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(cardBackgroundColor)
                
                Text("Loading plant details...")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // MARK: - Computed Properties
    
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
    
    // MARK: - Methods
    
    private func loadPlantDetails() async {
        if plantToDisplayInDetail != nil {
            return
        }
        
        let plantId = plant.id
        
        isLoading = true
        
        await fetchSpecificPlant(id: plantId) { plant in
            Task { @MainActor in
                if let plant = plant {
                    plantToDisplayInDetail = plant
                }
                isLoading = false
            }
        }
    }
    
    private func handleTap() {
        guard plantToDisplayInDetail != nil else { return }
        showDetail = true
    }
}

//struct PlantCardView: View {
//    
//    @Environment(\.colorScheme) var colorScheme
//    
//    @State var plant: PlantSpecies? = nil
//    
//    @State var plantImage: Image? = nil
//    @State var showDetail: Bool = false
//    @State var plantToDisplayInDetail: PlantData? = nil
//    
//    var body: some View {
//        ZStack {
//            VStack(spacing: 15) {
//                
//                Rectangle().background {
//                    if let imageURL = plant.imageURL {
//                        AsyncImage(url: URL(string: imageURL)) { phase in
//                            switch phase {
//                            case .empty:
//                                Image("golden-pothos")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .onAppear {
//                                        plantImage = Image("golden-pothos")
//                                    }
//                            case .success(let image):
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .onAppear {
//                                        plantImage = image
//                                    }
//                            case .failure:
//                                Image("golden-pothos")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .onAppear {
//                                        plantImage = Image("golden-pothos")
//                                    }
//                            @unknown default:
//                                Image("golden-pothos")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .onAppear {
//                                        plantImage = Image("golden-pothos")
//                                    }
//                            }
//                        }
//                    }
//                    else {
//                        Image("golden-pothos")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .onAppear {
//                                plantImage = Image("golden-pothos")
//                            }
//                    }
//                }
//                .foregroundColor(Color.clear)
//                
//                Text(plant.commonName ?? "Plant Not Found")
//                    .font(.footnote)
//                    .multilineTextAlignment(.center)
//                    .lineLimit(2)
//                    .fixedSize(horizontal: false, vertical: true)
//                    .foregroundColor(textColor)
//            }
//        }
//        .frame(width: 120, height: 120)
//        .cornerRadius(15)
//        .task {
//            if plantToDisplayInDetail == nil {
//                await fetchSpecificPlant(id: plant?.id) { plant in
//                    if let plant = plant {
//                        plantToDisplayInDetail = plant
//                    }
//                }
//            }
//        }
//        .onTapGesture {
//            if plantToDisplayInDetail != nil {
//                showDetail = true
//            }
//        }
//        .fullScreenCover(isPresented: $showDetail) {
//            if let plant = plantToDisplayInDetail, let plant_image = plantImage {
//                PlantCardDetailView(plantSpecies: plant, image: plant_image, showDetail: $showDetail)
//            }
//            else {
//                ZStack {
//                    Color(.systemBackground).ignoresSafeArea()
//                    ProgressView("Loading...")
//                        .tint(cardBackgroundColor)
//                        .scaleEffect(2.0)
//                }
//            }
//        }
//    }
//    
//    private var cardBackgroundColor: Color {
//        colorScheme == .light
//            ? Color(red: 250/255, green: 187/255, blue: 139/255)
//            : Color(red: 244/255, green: 218/255, blue: 198/255)
//    }
//    
//    private var textColor: Color {
//        colorScheme == .dark
//            ? Color(red: 0.3, green: 0.2, blue: 0.1)
//            : Color(red: 0.2, green: 0.15, blue: 0.1)
//    }
//    
//}

//#Preview {
//    PlantCardView()
//}
