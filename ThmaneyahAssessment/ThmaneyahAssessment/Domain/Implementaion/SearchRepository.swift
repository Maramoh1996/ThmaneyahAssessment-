//
//  SearchRepository.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 28/07/2025.
//

import Foundation

class SearchRepository {
    func search(query: String, in sections: [Section]) -> [SearchResult] {
        let lowercasedQuery = query.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !lowercasedQuery.isEmpty else { return [] }
        
        var results: [SearchResult] = []
        
        for section in sections {
            for item in section.content {
                print("Searching in item: \(item.contentName)")
                
                if let result = searchInItem(item, query: lowercasedQuery, type: section.contentType) {
                    results.append(result)
                }
            }
        }
        
        print("Found \(results.count) results for query: \(query)")
        
        return results.sorted { first, second in
            if first.matchedField == .name && second.matchedField != .name {
                return true
            }
            return false
        }
    }
    
    private func searchInItem(_ item: any ContentItem, query: String, type: Section.ContentType) -> SearchResult? {
        // Check if name contains query
        if item.contentName.lowercased().contains(query) {
            return SearchResult(item: item, type: type, matchedField: .name)
        }
        
        // Check specific properties based on type
        switch item {
        case let podcast as Podcast:
            if podcast.description.lowercased().contains(query) {
                return SearchResult(item: podcast, type: type, matchedField: .description)
            }
            
        case let episode as Episode:
            if let description = episode.description, description.lowercased().contains(query) {
                return SearchResult(item: episode, type: type, matchedField: .description)
            } else if episode.podcastName.lowercased().contains(query) {
                return SearchResult(item: episode, type: type, matchedField: .podcast)
            }
            
        case let audioBook as AudioBook:
            if audioBook.description.lowercased().contains(query) {
                return SearchResult(item: audioBook, type: type, matchedField: .description)
            } else if audioBook.authorName.lowercased().contains(query) {
                return SearchResult(item: audioBook, type: type, matchedField: .author)
            }
            
        case let article as AudioArticle:
            if article.description.lowercased().contains(query) {
                return SearchResult(item: article, type: type, matchedField: .description)
            } else if article.authorName.lowercased().contains(query) {
                return SearchResult(item: article, type: type, matchedField: .author)
            }
            
        default:
            break
        }
        
        return nil
    }
}
