//
//  SearchView.swift
//  Sprout
//
//  Created by Pratham  Hebbar on 8/5/25.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        
        ZStack {
            colorScheme == .dark ? Color(red: 250/255, green: 187/255, blue: 139/255).ignoresSafeArea() : Color(red: 244/255, green: 218/255, blue: 198/255).ignoresSafeArea()
            
            Text("Search and look through a collection of plants")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
        }
        .background(colorScheme == .light ? Color(red: 250/255, green: 187/255, blue: 139/255).ignoresSafeArea() : Color(red: 244/255, green: 218/255, blue: 198/255).ignoresSafeArea())
        
        

    }
}

#Preview {
    SearchView(colorScheme: .constant(.light))
}
