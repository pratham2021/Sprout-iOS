//
//  NewPlantClassifierView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/5/25.


//

import SwiftUI
import SwiftData
import PhotosUI

struct NewPlantClassifierView: View {
    
    @Environment(\.colorScheme) var colorScheme
//    Query(sort: \LocalPlantPrediction.name) var samples: [LocalPlantPrediction]
//    @Environment(\.modelContext) private var modelContext
    @State var samples: [LocalPlantPrediction] = []
    @State var showLibrary: Bool = false
    @State private var selectedItem: PhotosPickerItem? // holds the selected photo item
    @State private var selectedImage: UIImage?
    @State private var showingCamera: Bool = false
    @State private var showingPhotoLibrary: Bool = false

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack {
                
                HStack {
                    Text("Plant Predictions")
                        .foregroundColor(textColor)
                        .font(.title)
                        .fontWeight(.bold)
                        .textCase(nil)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        
                        
                        Button {
                            showingCamera = true
                        } label: {
                            Image(systemName: "camera")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(textColor)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .fullScreenCover(isPresented: $showingCamera) {
                            CameraView(image: $selectedImage)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "photo")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(textColor)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .fullScreenCover(isPresented: $showingPhotoLibrary) {
                           // Image picker
                        }
                        
                    }
                    
                }
                // .padding()
                
                
                List {
                    
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .listStyle(.plain)
                .environment(\.editMode, .constant(.inactive))
                .overlay {
                    if samples.isEmpty {
                        emptyStateView
                    }
                }
            }
            .padding()
        }
        .onChange(of: selectedImage) { newImage in
            if newImage != nil {
                print("Selected Image")
                print(newImage!)
            }
        }
        
    }
    
    @ViewBuilder
    private var emptyStateView: some View {
        ContentUnavailableView(label: {
            Label {
                Text("No Plant Predictions")
                    .foregroundColor(textColor)
            } icon: {
                Image(systemName: "sparkles")
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(textColor)
            }
        }, description: {
            Text("Import a plant from your photo library or take a plant through the camera.")
                .foregroundColor(textColor)
        }, actions: {
            
        })
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 250/255, green: 187/255, blue: 139/255)
            : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
}

 #Preview {
    NewPlantClassifierView()
 }
