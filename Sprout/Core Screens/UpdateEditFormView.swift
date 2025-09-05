//
//  UpdateEditFormView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 9/5/25.
//

import SwiftUI

struct UpdateEditFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var selectedImage: UI
    
    @State private var selectedItem: PhotosPickerItem? // holds the selected photo item
    @State private var selectedImage: UIImage?
    
    var body: some View {
        
    }
    
}

#Preview {
    UpdateEditFormView()
}
