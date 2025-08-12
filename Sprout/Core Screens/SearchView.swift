//  SearchView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/25.

import SwiftUI

struct SearchView: View {

    @Environment(\.colorScheme) var colorScheme
    @State var plantsSpecies: [Plant]
    @State var speciesPlantCareGuides: [SpeciesCarePlant]
    @State var plantDiseases: [PlantDisease]
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            List {
                Section(header: Text("Plant Species").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<plantsSpecies.count, id: \.self) { index in
                                  PlantCardView(plant: plantsSpecies[index])
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                
                Section(header: Text("Species Care Guide").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<speciesPlantCareGuides.count, id: \.self) { index in
                                SpeciesCarePlantView(speciesCarePlant: speciesPlantCareGuides[index])
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                
                Section(header: Text("Pest Disease").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<plantDiseases.count, id: \.self) { index in
                                PlantDiseaseView(plantDisease: plantDiseases[index])
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .listStyle(.insetGrouped)
        }
        .onAppear {
//            print(plantsSpecies.count)
//            print(speciesPlantCareGuides.count)
//            print(plantDiseases.count)
        }
    }
    
    private var cardBackgroundColor: Color {
        colorScheme == .light
        ? Color(red: 250/255, green: 187/255, blue: 139/255)
        : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 250/255, green: 187/255, blue: 139/255)
            : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .black : .black.opacity(0.8)
    }
    
    private var headerColor: Color {
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

#Preview {
    SearchView(plantsSpecies: [Plant](), speciesPlantCareGuides: [SpeciesCarePlant](), plantDiseases: [PlantDisease]()).preferredColorScheme(.light)
}
