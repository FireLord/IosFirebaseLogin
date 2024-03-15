//
//  User.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
}

extension User {
    static let MOCK_USER = User(id: UUID().uuidString, email: "test@gmail.com")
}
