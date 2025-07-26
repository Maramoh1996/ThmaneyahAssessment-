//
//  ScrollableTabContainer.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import SwiftUI

struct ScrollableTabContainer: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.tabs) { tab in
                    tabButton(for: tab)
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color.black)
    }
    
    @ViewBuilder
    private func tabButton(for tab: TabItem) -> some View {
        let isSelected = viewModel.isTabSelected(tab.id)
        
        Button(action: { viewModel.selectTab(tab.id) }) {
            Text(tab.title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.red : Color.clear)
                )
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
