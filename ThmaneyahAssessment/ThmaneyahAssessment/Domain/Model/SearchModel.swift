//
//  SearchModel.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 28/07/2025.
//
import Foundation

// MARK: - Search Result Model
struct SearchResult: Identifiable {
    let id = UUID()
    let item: any ContentItem
    let type: Section.ContentType
    let matchedField: MatchedField
    
    enum MatchedField {
        case name
        case description
        case author
        case podcast
    }
}
