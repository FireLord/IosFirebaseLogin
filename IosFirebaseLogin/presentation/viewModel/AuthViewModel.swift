//
//  AuthViewModel.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
import GoogleSignInSwift

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
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            let user = User(id: result.user.uid, email: email)
            let encodeUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id).setData(encodeUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed with error \(error.localizedDescription)")
        }
    }
    
    func signInGoogle() async throws {
        do {
            guard let topVC = TopViewUtil.shared.topViewController() else {
                throw URLError(.cannotFindHost)
            }

            let googleResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
            
            guard let idToken = googleResult.user.idToken?.tokenString else {
                throw URLError(.cannotFindHost)
            }
            
            let accessToken = googleResult.user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            let result = try await Auth.auth().signIn(with: credential)
            userSession = result.user
            let user = User(id: result.user.uid, email: result.user.email!)
            let encodeUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id).setData(encodeUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
            currentUser = nil
        } catch {
            print("DEBUG: Failed with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async throws {
        do {
            guard let user = userSession else {
                throw URLError(.cannotFindHost)
            }
            try await user.delete()
            let uid = user.uid
            try await Firestore.firestore().collection("user").document(uid).delete()
            signOut()
        } catch {
            print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("user").document(uid).getDocument() else { return }
        currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: current user is \(String(describing: currentUser))")
    }
    
    func forgotPassword(withEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("DEBUG: Failed with error \(error.localizedDescription)")
        }
    }
}
