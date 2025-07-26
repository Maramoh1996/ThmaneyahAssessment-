//
//  UserServiceImplementation.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import Foundation

class UserServiceImplementation: UserServiceProtocol {
    func getCurrentUser() -> UserProfile {
        return UserProfile(
            name: "عبدالرحمن",
            greeting: "مساء الخير"
        )
    }
}
