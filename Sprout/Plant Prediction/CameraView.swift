//
//  CameraView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/5/25.
//

import Foundation
import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage? // bind to the parent view's state
    @Environment(\.presentationMode) var presentationMode // Dismiss the view controller done
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController() // Create the Camera picker
        picker.delegate = context.coordinator // Set the coordinator as delegate
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed here
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image // pass the selected image to the parent
            }
            
            // Generate prediction and then dismiss
            
            
            parent.presentationMode.wrappedValue.dismiss() // dismiss the picker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            parent.presentationMode.wrappedValue.dismiss() // Dismiss on cancel
        }
        
    }
    
}
