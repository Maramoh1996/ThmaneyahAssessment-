//
//  NavigationHeaderView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import SwiftUI

struct NavigationHeaderView: View {
    @ObservedObject var viewModel: NavigationViewModel
    @ObservedObject var tabBarViewModel: TabBarViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                profileButton
                Spacer()
                greetingText
                Spacer()
                notificationButton
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.black)
            
            ScrollableTabsView(viewModel: tabBarViewModel)
        }
    }
    
    @ViewBuilder
    private var profileButton: some View {
        Button(action: viewModel.profileTapped) {
            Circle()
                .fill(Color.green)
                .frame(width: 32, height: 32)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                )
        }
    }
    
    @ViewBuilder
    private var greetingText: some View {
        Text(viewModel.greetingText)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var notificationButton: some View {
        Button(action: viewModel.notificationTapped) {
            Image(systemName: "bell")
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}
