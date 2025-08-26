//
//  EdiblePlantCardView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/25/25.
//

import SwiftUI

struct EdiblePlantCardView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var ediblePlant: EdiblePlantSpecies
    @State private var plantImage: Image?
    @State private var showEdibleDetail = false
    @State private var isLoading = false
    @State private var ediblePlantToDisplayInDetail: PlantData?
    
    private let cardSize: CGFloat = 120
    private let cornerRadius: CGFloat = 15
    private let spacing: CGFloat = 15
    private let fallbackImageName = "golden-pothos"
    
    var body: some View {
        VStack(spacing: spacing) {
            ediblePlantImage
            ediblePlantNameText
        }
        .frame(width: cardSize, height: cardSize)
        .cornerRadius(cornerRadius)
        .task {
            await loadPlantDetails()
        }
        .onTapGesture {
            if plantImage != Image("golden-pothos") {
                handleTap()
            }
        }
        .fullScreenCover(isPresented: $showEdibleDetail) {
            ediblePlantDetailView
        }
    }
    
    private func loadPlantDetails() async {
        if ediblePlantToDisplayInDetail != nil {
            return
        }
        
        let plantId = ediblePlant.id
        
        isLoading = true
        
        await fetchEdiblePlant(plantId: plantId) { plant in
            Task { @MainActor in
                if let plant = plant {
                    ediblePlantToDisplayInDetail = plant
                }
                isLoading = false
            }
        }
    }
    
    private func handleTap() {
        print(ediblePlant != nil)
        print(ediblePlantToDisplayInDetail != nil)
        guard ediblePlant != nil else { return }
        showEdibleDetail = true
    }
    
    @ViewBuilder
    private var ediblePlantDetailView: some View {
        if ediblePlant != nil && ediblePlantToDisplayInDetail != nil {
            EdiblePlantDetailView(ediblePlant: ediblePlant, plantToDisplayInDetail: ediblePlantToDisplayInDetail!, showDetail: $showEdibleDetail)
        }
        else {
            loadingView
        }
    }
    
    @ViewBuilder
    private var ediblePlantImage: some View {
        Group {
            if let imageURL = ediblePlant.imageUrl {
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
                .onAppear {
                    plantImage = image
                }
        case .failure:
            fallbackImage
        @unknown default:
            fallbackImage
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
    
    private var fallbackImage: some View {
        Image(fallbackImageName)
            .resizable()
            .onAppear {
                plantImage = Image(fallbackImageName)
            }
    }
    
    @ViewBuilder
    private var ediblePlantNameText: some View {
        Text(ediblePlant.commonName ?? "Plant Not Found")
            .font(.footnote)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(textColor)
    }
    
    private var loadingView: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(cardBackgroundColor)
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
    
}

// #Preview {
//     EdiblePlantCardView()
// }
