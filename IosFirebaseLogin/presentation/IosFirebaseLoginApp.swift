//
//  IosFirebaseLoginApp.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import SwiftUI
import Firebase
import FirebaseAnalytics
import FirebaseAnalyticsSwift
import FirebaseCore

@main
struct IosFirebaseLoginApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            DashView().environmentObject(viewModel)
                .onAppear() {
                    Analytics.logEvent(AnalyticsEventScreenView,
                                       parameters: [AnalyticsParameterScreenName: "\(IosFirebaseLoginApp.self)",
                                                   AnalyticsParameterScreenClass: "\(IosFirebaseLoginApp.self)"])
                }
        }
    }
}
