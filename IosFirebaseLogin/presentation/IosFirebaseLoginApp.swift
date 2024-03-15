//
//  IosFirebaseLoginApp.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import SwiftUI
import Firebase

@main
struct IosFirebaseLoginApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            DashView().environmentObject(viewModel)
        }
    }
}
