//
//  SearchView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 28/07/2025.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    @State private var isActive = false
    let sections: [Section]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $searchViewModel.searchText, isActive: $isActive) {
                    searchViewModel.performSearch()
                }
                if searchViewModel.searchText.isEmpty && !isActive {
                    recentSearchesView
                } else if searchViewModel.isSearching {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if searchViewModel.searchResults.isEmpty && !searchViewModel.searchText.isEmpty {
                    noResultsView
                } else {
                    searchResultsView
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .background(Color.black)
        }
        .preferredColorScheme(.dark)
        .onAppear {
            print("SearchView appeared with \(sections.count) sections")
            searchViewModel.setSections(sections)
        }
        
    }
    
    // MARK: - Recent Searches View
    var recentSearchesView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if !searchViewModel.recentSearches.isEmpty {
                    HStack {
                        Text("Recent Searches")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button("Clear") {
                            searchViewModel.clearRecentSearches()
                        }
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    ForEach(searchViewModel.recentSearches, id: \.self) { search in
                        RecentSearchRow(search: search) {
                            searchViewModel.searchText = search
                            searchViewModel.performSearch()
                            isActive = true
                        } onDelete: {
                            searchViewModel.removeRecentSearch(search)
                        }
                    }
                }
            }
            .padding(.top)
        }
    }
    
    // MARK: - No Results View
    var noResultsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No results for '\(searchViewModel.searchText)'")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text("Try searching for something else")
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Search Results View
    var searchResultsView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(searchViewModel.searchResults) { result in
                    SearchResultRow(result: result)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Search Bar
struct SearchBar: View {
    @Binding var text: String
    @Binding var isActive: Bool
    let onSubmit: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search podcasts, episodes...", text: $text)
                    .foregroundColor(.white)
                    .onSubmit {
                        onSubmit()
                    }
                    .onChange(of: text) { _ in
                        onSubmit()
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                        isActive = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            if isActive {
                Button("Cancel") {
                    text = ""
                    isActive = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .animation(.easeInOut(duration: 0.2), value: isActive)
        .onTapGesture {
            isActive = true
        }
    }
}

// MARK: - Recent Search Row
struct RecentSearchRow: View {
    let search: String
    let onTap: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "clock.arrow.circlepath")
                .foregroundColor(.gray)
                .frame(width: 20)
            
            Text(search)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: - Search Result Row
struct SearchResultRow: View {
    let result: SearchResult
    
    var body: some View {
        HStack(spacing: 12) {
            // Image
            AsyncImage(url: URL(string: result.item.contentImageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(result.item.contentName)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(typeAndMatchedField)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray.opacity(0.7))
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(.vertical, 8)
        .background(Color.black)
    }
    
    var typeAndMatchedField: String {
        let type = result.type.rawValue.replacingOccurrences(of: "_", with: " ").capitalized
        let field: String
        
        switch result.matchedField {
        case .name:
            field = "Title"
        case .description:
            field = "Description"
        case .author:
            field = "Author"
        case .podcast:
            field = "Podcast"
        }
        
        return "\(type) • Found in \(field)"
    }
    
    var subtitle: String? {
        switch result.item {
        case let episode as Episode:
            return episode.podcastName
        case let audioBook as AudioBook:
            return audioBook.authorName
        case let article as AudioArticle:
            return article.authorName
        default:
            return nil
        }
    }
}
