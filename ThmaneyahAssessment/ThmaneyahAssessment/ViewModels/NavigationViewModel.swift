//
//  NavigationViewModel.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    
    private let navigationService: NavigationServiceProtocol
    private let userService: UserServiceProtocol
    
    init(
        navigationService: NavigationServiceProtocol = NavigationServiceImplementation(),
        userService: UserServiceProtocol = UserServiceImplementation()
    ) {
        self.navigationService = navigationService
        self.userService = userService
        self.userProfile = userService.getCurrentUser()
    }
    
    var greetingText: String {
        "\(userProfile.greeting)، \(userProfile.name)"
    }
    
    func profileTapped() {
        navigationService.handleProfileTap()
    }
    
    func notificationTapped() {
        navigationService.handleNotificationTap()
    }
}
