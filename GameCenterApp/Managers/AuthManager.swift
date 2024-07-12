//
//  AuthManager.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 26.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var currentUser: GCUser?
    
    func setCurrentUser() async {
        let authUserEmail = Auth.auth().currentUser?.email
        do {
            if authUserEmail != nil {
                let result = try await Firestore.firestore().collection(FirestoreCollections.Users).whereField("email", isEqualTo: authUserEmail!).getDocuments()
                self.currentUser = try result.documents.first!.data(as: GCUser.self)
            }
        } catch { print("error") }
        
        /*
        if authUserEmail != nil {
            Firestore.firestore().collection(FirestoreCollections.Users).whereField("email", isEqualTo: authUserEmail!).getDocuments { snapshot, error in
                guard let snapshot, error == nil else {
                    return
                }
                do {
                    let user = try snapshot.documents.first!.data(as: GCUser.self)
                    self.currentUser = user
                } catch {
                    print("setCurrentUser error")
                }
            }
        }
        */
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, GCError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                completion(.failure(.invalidUsernameOrPassword))
                return
            }
            completion(.success(()))
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch { print("error") }
        
    }
}
