//
//  Utilities.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/9/2025.

import Foundation
import Firebase
import FirebaseFirestore

var PLANT_API_KEY: String {
    get async {
        let db = Firestore.firestore()
        let docRef = db.collection("keys").document("api keys")
        let document = try? await docRef.getDocument()
        return document?.data()?["plantAPI"] as! String
    }
}

var PLANT_PREDICTION_API_KEY: String {
    get async {
        let db = Firestore.firestore()
        let docRef = db.collection("keys").document("api keys")
        let document = try? await docRef.getDocument()
        return document?.data()?["plantPredictionAPI"] as! String
    }
}
