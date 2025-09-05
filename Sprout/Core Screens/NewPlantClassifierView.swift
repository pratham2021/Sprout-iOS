//
//  NewPlantClassifierView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/5/2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct NewPlantClassifierView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
//    Query(sort: \LocalPlantPrediction.name) var localPlantPredictions: [LocalPlantPrediction]
    @Environment(\.modelContext) private var modelContext
    @State var localPlantPredictions: [LocalPlantPrediction] = []
    @State var showLibrary: Bool = false
    @State private var photosPickerItem: PhotosPickerItem? // holds the selected photo item
    @State private var selectedImage: UIImage?
    @State private var showingCamera: Bool = false
    @StateObject private var classifier = PlantClassifierService()    

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            NavigationStack {
                
                VStack {
                    List {
                        
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .listStyle(.plain)
                    .environment(\.editMode, .constant(.inactive))
                    .overlay {
                        if localPlantPredictions.isEmpty {
                            emptyStateView
                        }
                    }
                }
                .padding()
                .navigationTitle(
                    Text("Plant Predictions")
                        .foregroundColor(textColor)
                        .font(.title)
                        .fontWeight(.bold)
                        .textCase(nil)
                )
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showingCamera = true
                        }, label: {
                            Image(systemName: "camera")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(textColor)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            Image(systemName: "photo")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(textColor)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .fullScreenCover(isPresented: $showingCamera) {
                CameraView(image: $selectedImage)
            }
        }
        .background(Color.clear)
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
                
                guard let image = selectedImage else { return }

                // Fire off an API call
                
                
                
                photosPickerItem = nil
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
