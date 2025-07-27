//
//  HomeView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//
import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.sections) { section in
                            SectionView(section: section)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Home")
            .refreshable {
                await viewModel.loadHomeSections()
            }
        }
        .onAppear {
            Task {
                await viewModel.loadHomeSections()
            }
        }
    }
}
