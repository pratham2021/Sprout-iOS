//  SearchView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/25.

import SwiftUI

struct SearchView: View {

    @Environment(\.colorScheme) var colorScheme
    @State var plants: [PlantSpecies] = [PlantSpecies]()
    @State var distributions: [Distribution] = [Distribution]()
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            List {
                Section(header: Text("Plant Species").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<plants.count, id: \.self) { index in
                                PlantCardView(plant: plants[index])
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                
                Section(header: Text("Distributions").foregroundColor(headerColor).font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(0..<distributions.count, id: \.self) { index in
                                DistributionCardView(distribution: distributions[index])
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
    SearchView().preferredColorScheme(.light)
}
