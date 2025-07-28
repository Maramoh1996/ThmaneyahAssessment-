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
        TabView {
            HomeTabView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                }
            SearchView(sections: viewModel.sections)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct HomeTabView: View {
    @ObservedObject var viewModel: HomeViewModel
    
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
                    Text("لا يوجد محتوى")
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
        .onAppear {
            Task {
                await viewModel.loadHomeSections()
            }
        }
    }
}

struct FavoritesView: View {
    var body: some View {
        Text("المفضلة")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("الحساب")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
    }
}
