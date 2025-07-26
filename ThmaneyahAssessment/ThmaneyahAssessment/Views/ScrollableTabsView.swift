//
//  ScrollableTabsView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import SwiftUI

struct ScrollableTabsView: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        ScrollableTabContainer(viewModel: viewModel)
    }
}
