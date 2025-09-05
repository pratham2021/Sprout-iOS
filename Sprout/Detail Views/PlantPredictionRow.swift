//
//  PlantPredictionRow.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/4/25.
//

import Foundation
import SwiftUI

struct PlantPredictionRow: View {
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
//    let rank: Int
//    let prediction: PlantPrediction
//    
//    var body: some View {
//        HStack {
//            // Rank circle
//            Circle()
//                .fill(rankColor)
//                .frame(width: 24, height: 24)
//                .overlay(
//                    Text("\(rank)")
//                        .font(.caption)
//                        .fontWeight(.medium)
//                        .foregroundColor(.white)
//                )
//            
//            VStack(alignment: .leading, spacing: 2) {
//                Text( /* prediction.className */ "Unknown")
//                    .font(.body)
//                    .fontWeight(.medium)
//                
////                if let confidence = prediction.confidence {
////                    Text("Confidence: \(String(format: "%.1f", confidence * 100))%")
////                        .font(.caption)
////                        .foregroundColor(.secondary)
////                }
//            }
//            
//            Spacer()
//            
//            // Confidence bar
//            if let confidence = prediction.confidence {
//                ProgressView(value: confidence)
//                    .frame(width: 60)
//                    .tint(confidenceColor(confidence))
//            }
//        }
//        .padding(.vertical, 4)
//    }
//    
//    private var rankColor: Color {
//        switch rank {
//        case 1: return .green
//        case 2: return .blue
//        case 3: return .orange
//        default: return .gray
//        }
//    }
//    
//    private func confidenceColor(_ confidence: Double) -> Color {
//        if confidence > 0.8 { return .green }
//        else if confidence > 0.6 { return .orange }
//        else { return .red }
//    }
}
