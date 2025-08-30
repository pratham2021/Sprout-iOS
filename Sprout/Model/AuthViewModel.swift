//  AuthViewModel.swift
//  Sprout
//  Created by Pratham  Hebbar on 8/8/2025.

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore



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
    
    func signIn(withEmail email: String, password: String) async throws {
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            await fetchUser()
//        } catch {
//            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
//            
//        }
        
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        await fetchUser()
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            self.userSession = result.user
//            let user = User(id: result.user.uid, fullName: fullName, email: email)
//            let encodedUser = try Firestore.Encoder().encode(user)
//            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
//            await fetchUser()
//        } catch {
//            print("Failed to create user with error: \(error.localizedDescription)")
//        }
        
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        let user = User(id: result.user.uid, fullName: fullName, email: email)
        let encodedUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        await fetchUser()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign out the user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out the user stored locally on the device
        } catch {
            print("Error signing out the user")
        }
    }
    
    func deleteAccount() {
        print("Delete")
        
        do {
            
            if self.userSession == nil || self.currentUser == nil {
                return
            }
            
            try Auth.auth().currentUser?.delete { error in
                if error == nil {
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
            }
        }
        catch {
            print("Error deleting user")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {
            return
        }
        
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
