//  SearchView.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/5/25.

import SwiftUI

struct SearchView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var locationManager: LocationManager
    @State var fruits: [Plant] = []
    @State var flowers: [Plant] = []
    @State var herbs: [Plant] = []
    @State var vegetables: [Plant] = []
    
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                if fruits.count != 0 {
                    Text("fruits")
                }
                
                if flowers.count != 0 {
                    Text("flowers")
                }
                
                if herbs.count != 0 {
                    Text("herbs")
                }
                
                if vegetables.count != 0 {
                    Text("vegetables")
                }
            }
           
            
        }
        
        .onAppear {
            guard let zip = locationManager.zipCode, locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways else {
                fetchAllPlants(for: "")
                return
            }
            
            var zone = fetchZone(for: zip) { zone in
                
            }
            
            fetchAllPlants(for: "")
        }
        .task(id: locationManager.zipCode) {
            guard let zip = locationManager.zipCode, locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways else {
                fetchAllPlants(for: "")
                return
            }
           
            var zone = fetchZone(for: zip) { zone in
                
            }
            
            fetchAllPlants(for: "")
        }
        
        
    }
    
    private func fetchAllPlants(for zip: String) {
        let group = DispatchGroup()
        
        var fetchedFruits: [Plant]?
        var fetchedFlowers: [Plant]?
        var fetchedHerbs: [Plant]?
        var fetchedVegetables: [Plant]?
        
        group.enter()
        
        fetchFruits(zip: zip) { plants in
            fetchedFruits = plants
            group.leave()
        }
        
        group.enter()
        fetchFlowers(zip: zip) { plants in
            fetchedFlowers = plants
            group.leave()
        }
        
        group.enter()
        fetchHerbs(zip: zip) { plants in
            fetchedHerbs = plants
            group.leave()
        }
        
        
        group.enter()
        fetchVegetables(zip: zip) { plants in
            fetchedVegetables = plants
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let fruits = fetchedFruits { self.fruits = fruits }
            if let flowers = fetchedFlowers { self.flowers = flowers }
            if let herbs = fetchedHerbs { self.herbs = herbs }
            if let vegetables = fetchedVegetables { self.vegetables = vegetables }
        }
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark
            ? Color(red: 250/255, green: 187/255, blue: 139/255)
            : Color(red: 244/255, green: 218/255, blue: 198/255)
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .black : .black.opacity(0.8)
    }
}

#Preview {
    SearchView(fruits: [Plant](), flowers: [Plant](), herbs: [Plant](), vegetables: [Plant]()).preferredColorScheme(.light)
}
