//  AuthViewModel.swift
//  Sprout
//  Created by Pratham  Hebbar on 9/3/25.

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SwiftData

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        await fetchUser()
    }
    
    func createAccount(withEmail email: String, password: String, fullName: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        let user = User(id: result.user.uid, fullName: fullName, email: email)
        let encodedUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        await fetchUser()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign out the user from Firebase backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out the user stored locally on the device
        } catch {
            print("Error signing out the user")
        }
        
    }
    
    func deleteAccount() {
        
        var collectionID = self.userSession!.uid
        
        try Auth.auth().currentUser?.delete { error in
            let db = Firestore.firestore()
            
            let userID = self.userSession!.uid
            
            db.collection("users").document(userID).delete { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.userSession = nil
                        self.currentUser = nil
                    }
                }
            }
        }
        
        deleteAllDocuments(in: collectionID)
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func deleteAllDocuments(in collectionName: String) {
        let db = Firestore.firestore()
        let collection = db.collection(collectionName)
        
        // Get all documents
        collection.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents")
                return
            }
            
            let batch = db.batch()
            
            for document in documents {
                batch.deleteDocument(document.reference)
            }
            
            // Commit the batch
            batch.commit { error in
                if let error = error {
                    print("Error deleting documents")
                }
                else {
                    print("All documents deleted successfully")
                }
            }
            
        }
    }
}
