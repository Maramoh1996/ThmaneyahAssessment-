//
//  ContentView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            MainNavigationBarView()
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 100)
                } else if viewModel.sections.isEmpty {
                    Text("No content available")
                        .foregroundColor(.gray)
                        .padding(.top, 100)
                } else {
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.sections) { section in
                            SectionView(section: section)
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
            .refreshable {
                await viewModel.loadHomeSections()
            }
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
        .environment(\.layoutDirection, .rightToLeft)
        .onAppear {
            Task {
                await viewModel.loadHomeSections()
            }
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button("OK") {
                viewModel.error = nil
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error")
        }
    }
}

#Preview {
    ContentView()
}
