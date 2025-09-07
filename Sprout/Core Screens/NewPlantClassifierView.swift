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
    @Environment(\.modelContext) var modelContext
    @Query var scannedPlants: [ScannedPlant]
    @State var showLibrary: Bool = false
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var showingCamera: Bool = false
    @StateObject private var classifier = PlantClassifierService()
    @State var alertMessage: String = ""
    @State var isShowingAlert: Bool = false
    @State var alertBody: String = ""
    @State private var showCamera = false

    var body: some View {
        NavigationStack {
            ZStack {
                mainStack
                
                if classifier.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: textColor))
                        .scaleEffect(2)
                }
            }
        }
        .background(backgroundColor.ignoresSafeArea())
        .fullScreenCover(isPresented: $showingCamera) {
            CameraView(image: $selectedImage).ignoresSafeArea(.all)
        }
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
                
                guard let image = selectedImage else { return }
                
                photosPickerItem = nil
            }
        }
        .onChange(of: selectedImage) {
            if let image = selectedImage {
                Task {
                    await classifier.classifyPlant(image: image) { plantPredictions, errorMessage in
                        
                        if !plantPredictions.isEmpty {
                            var localPlantPredictions = [LocalPlantPrediction]()
                            
                            for prediction in plantPredictions {
                                let localPlantPrediction = LocalPlantPrediction(scientificName: prediction.scientificName, probability: prediction.probability)
                                localPlantPredictions.append(localPlantPrediction)
                            }
                            
                            let scannedPlant = ScannedPlant(imageData: image.pngData()!, plantPredictions: localPlantPredictions)
                            
                            modelContext.insert(scannedPlant)
                            
                            do {
                                try modelContext.save()
                            }
                            catch {
                                
                            }
                        }
                        else {
                            isShowingAlert = true
                            alertMessage = errorMessage
                        }
                    }
                }
            }
            selectedImage = nil
        }
        .alert(alertMessage, isPresented: $isShowingAlert) {
            Button("OK") {
                alertBody = ""
            }
        } message: {
            if alertMessage == "Failed to convert image into JPG" {
                Text("There was an error converting the image into a JPG file to send to the API.")
            }
            else if alertMessage == "Invalid URL" {
                Text("There was an error with the API endpoint.")
            }
            else if alertMessage == "Failed to create request body" {
                Text("There was an error creating request body to send to the API.")
            }
            else if alertMessage == "Invalid response" {
                Text("There was an error getting a response from the API")
            }
            else if alertMessage == "No data" {
                Text("There was an error reading the data from the API")
            }
            else if alertMessage != "" {
                Text(alertBody)
            }
        }
        .tint(alertTextColor)
        
    }
    
    @ViewBuilder
    private var mainStack: some View {
        
        List {
            ForEach(scannedPlants) { scannedPlant in
                PlantPredictionListRow(scannedPlant: scannedPlant)
                    .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .contentMargins(.all, 0)
        .listRowSpacing(0)
        .scrollDisabled(scannedPlants.count == 0)
        .scrollContentBackground(.hidden)
        .background(backgroundColor)
        .listStyle(.plain)
        .environment(\.editMode, .constant(.inactive))
        .environment(\.defaultMinListRowHeight, 0)
        .overlay {
            if (scannedPlants.count == 0) {
                emptyStateView
            }
        }
        .background(backgroundColor)
        .navigationTitle("Plant Predictions")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            updateNavigationAppearance()
        }
        .onChange(of: colorScheme) { _, _ in
            updateNavigationAppearance()
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    if let error = CameraPermission.checkPermissions() {
                        alertMessage = error.errorDescription ?? ""
                        alertBody = error.recoverySuggestion ?? ""
                        isShowingAlert = true
                    }
                    else {
                        showingCamera = true
                    }
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
        colorScheme == .dark
            ? Color(red: 0.3, green: 0.2, blue: 0.1)
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
    
    private var alertTextColor: Color {
        colorScheme == .dark
            ? Color.white
            : Color(red: 0.2, green: 0.15, blue: 0.1)
    }
    
    private func updateNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(backgroundColor)
        appearance.shadowColor = .clear
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(textColor),
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(textColor),
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(textColor)
        
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.subviews.forEach { view in
                    view.removeFromSuperview()
                    window.addSubview(view)
                }
            }
        }
    }
    
    private func updateNavigationAppearanceNew() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(backgroundColor)
        appearance.shadowColor = .clear
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(textColor),
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(textColor),
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(textColor)
    }
}

// #Preview {
//    NewPlantClassifierView()
// }
