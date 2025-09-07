//
//  PlantPredictionListRow.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/7/25.
//

import SwiftUI

struct PlantPredictionListRow: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var scannedPlant: ScannedPlant
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(cardBackgroundColor.opacity(0.8))
            
            HStack(alignment: .center, spacing: 12) {
                Image(uiImage: scannedPlant.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(5)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .center, spacing: 8) {
                        ForEach(scannedPlant.plantPredictions.sorted(by: { $0.probability > $1.probability })) { plantPrediction in
                            HStack {
                                Text(plantPrediction.scientificName)
                                    .foregroundStyle(textColor)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                Text("\(formattedAsSmartPercentage(plantPrediction.probability))")
                                    .foregroundStyle(textColor)
                                    .fontWeight(.semibold)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .padding(12)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 4)
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
    
    func formattedAsSmartPercentage(_ value: Double) -> String {
        let percentage = value * 100
        
        if percentage == floor(percentage) {
            return value.formatted(.percent.precision(.fractionLength(0)))
        }
        else if (percentage * 10).rounded() / 10 == percentage {
            return value.formatted(.percent.precision(.fractionLength(1)))
        }
        else {
            return value.formatted(.percent.precision(.fractionLength(2)))
        }
        
    }
    
}

// #Preview {
//    PlantPredictionListRow()
// }
