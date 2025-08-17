//  PlantCardDetailView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/13/2025.

import SwiftUI

struct PlantCardDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var plantSpecies: PlantData
    var image: Image
    @Binding var showDetail:Bool
    
    var body: some View {
        ZStack {
            screenBackgroundColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(plantSpecies.commonName ?? "")
                                .font(.title)
                                .bold()
                            
                        }
                    }
                    
                    HStack {
                        Button {
                            // save to local on device storage
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(cardBackgroundColor)
                                    .frame(height: 40)
                                
                                Text("Save locally")
                                    .foregroundColor(textColor)
                            }
                        }
                        
                        Button("Dismiss") {
                            showDetail = false
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
        }
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
