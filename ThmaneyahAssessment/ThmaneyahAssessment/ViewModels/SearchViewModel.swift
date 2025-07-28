//
//  SearchViewModel.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 28/07/2025.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var searchResults: [SearchResult] = []
    @Published var isSearching = false
    @Published var recentSearches: [String] = []
    
    private let searchService = SearchRepository()
    private var sections: [Section] = []
    private var searchTask: Task<Void, Never>?
    
    init() {
        loadRecentSearches()
    }
    
    func setSections(_ sections: [Section]) {
        self.sections = sections
    }
    
    func performSearch() {
        searchTask?.cancel()
        
        let query = searchText
        
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        addToRecentSearches(query)
        
        isSearching = true
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
            
            guard !Task.isCancelled else { return }
            
            let results = searchService.search(query: query, in: sections)
            
            await MainActor.run {
                self.searchResults = results
                self.isSearching = false
            }
        }
    }
    
    func clearSearch() {
        searchText = ""
        searchResults = []
        searchTask?.cancel()
    }
    
    // MARK: - Recent Searches
    private func loadRecentSearches() {
        recentSearches = UserDefaults.standard.stringArray(forKey: "RecentSearches") ?? []
    }
    
    private func addToRecentSearches(_ query: String) {
        // Remove if already exists
        recentSearches.removeAll { $0.lowercased() == query.lowercased() }
        
        // Add to beginning
        recentSearches.insert(query, at: 0)
        
        // Keep only last 10
        if recentSearches.count > 10 {
            recentSearches = Array(recentSearches.prefix(10))
        }
        
        // Save to UserDefaults
        UserDefaults.standard.set(recentSearches, forKey: "RecentSearches")
    }
    
    func removeRecentSearch(_ search: String) {
        recentSearches.removeAll { $0 == search }
        UserDefaults.standard.set(recentSearches, forKey: "RecentSearches")
    }
    
    func clearRecentSearches() {
        recentSearches = []
        UserDefaults.standard.removeObject(forKey: "RecentSearches")
    }
}
