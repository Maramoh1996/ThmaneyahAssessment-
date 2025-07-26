//
//  MainNavigationBarView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import Foundation
import SwiftUI

struct MainNavigationBarView: View {
    @StateObject private var navigationViewModel: NavigationViewModel
    @StateObject private var tabBarViewModel: TabBarViewModel
    
    init(
        navigationViewModel: NavigationViewModel = NavigationViewModel(),
        tabBarViewModel: TabBarViewModel = TabBarViewModel()
    ) {
        self._navigationViewModel = StateObject(wrappedValue: navigationViewModel)
        self._tabBarViewModel = StateObject(wrappedValue: tabBarViewModel)
    }
    
    var body: some View {
        NavigationHeaderView(
            viewModel: navigationViewModel,
            tabBarViewModel: tabBarViewModel
        )
    }
}
