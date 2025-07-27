//
//  HomeResponse.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation

struct HomeResponse: Codable {
    let sections: [Section]
    let pagination: Pagination
}

struct Section: Codable, Identifiable {
    let name: String
    let type: SectionType
    let contentType: ContentType
    let order: Int
    let content: [any ContentItem]
    
    var id: Int { order }
    
    enum SectionType: String, Codable {
        case square
        case twoLinesGrid = "2_lines_grid"
        case bigSquare = "big_square"     // For sections with underscore
        case bigSquareSpace = "big square" // For sections with space
        case queue
    }
    
    enum ContentType: String, Codable {
        case podcast
        case episode
        case audioBook = "audio_book"
        case audioArticle = "audio_article"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(SectionType.self, forKey: .type)
        contentType = try container.decode(ContentType.self, forKey: .contentType)
        order = try container.decode(Int.self, forKey: .order)
        
        switch contentType {
        case .podcast:
            let podcasts = try container.decode([Podcast].self, forKey: .content)
            content = podcasts.map { $0 as any ContentItem }
        case .episode:
            let episodes = try container.decode([Episode].self, forKey: .content)
            content = episodes.map { $0 as any ContentItem }
        case .audioBook:
            let audioBooks = try container.decode([AudioBook].self, forKey: .content)
            content = audioBooks.map { $0 as any ContentItem }
        case .audioArticle:
            let articles = try container.decode([AudioArticle].self, forKey: .content)
            content = articles.map { $0 as any ContentItem }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(contentType, forKey: .contentType)
        try container.encode(order, forKey: .order)
        
        switch contentType {
        case .podcast:
            let podcasts = content.compactMap { $0 as? Podcast }
            try container.encode(podcasts, forKey: .content)
        case .episode:
            let episodes = content.compactMap { $0 as? Episode }
            try container.encode(episodes, forKey: .content)
        case .audioBook:
            let audioBooks = content.compactMap { $0 as? AudioBook }
            try container.encode(audioBooks, forKey: .content)
        case .audioArticle:
            let articles = content.compactMap { $0 as? AudioArticle }
            try container.encode(articles, forKey: .content)
        }
    }
}

// MARK: - Content Types
protocol ContentItem: Codable, Identifiable {
    var contentId: String { get }
    var contentName: String { get }
    var contentImageUrl: String { get }
}

extension ContentItem {
    var id: String { contentId }
}

struct Podcast: ContentItem {
    let podcastId: String
    let name: String
    let description: String
    let avatarUrl: String
    let episodeCount: Int
    let duration: Int
    let priority: Int?
    let popularityScore: Int?
    let score: Double
    let language: String?
    
    var contentId: String { podcastId }
    var contentName: String { name }
    var contentImageUrl: String { avatarUrl }
    
    enum CodingKeys: String, CodingKey {
        case podcastId = "podcast_id"
        case name, description
        case avatarUrl = "avatar_url"
        case episodeCount = "episode_count"
        case duration, priority
        case popularityScore
        case score, language
    }
}

struct Episode: ContentItem {
    let episodeId: String
    let name: String
    let seasonNumber: Int?
    let episodeType: String?
    let podcastName: String
    let authorName: String?
    let description: String?
    let number: Int?
    let duration: Int
    let avatarUrl: String
    let separatedAudioUrl: String?
    let audioUrl: String
    let releaseDate: String
    let podcastId: String
    let chapters: [String]?
    let podcastPopularityScore: Int?
    let podcastPriority: Int?
    let score: Double?
    
    var contentId: String { episodeId }
    var contentName: String { name }
    var contentImageUrl: String { avatarUrl }
    
    enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case name
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case description, number, duration
        case avatarUrl = "avatar_url"
        case separatedAudioUrl = "separated_audio_url"
        case audioUrl = "audio_url"
        case releaseDate = "release_date"
        case podcastId = "podcast_id"
        case chapters
        case podcastPopularityScore
        case podcastPriority
        case score
    }
}

struct AudioBook: ContentItem {
    let audiobookId: String
    let name: String
    let authorName: String
    let description: String
    let avatarUrl: String
    let duration: Int
    let language: String
    let releaseDate: String
    let score: Double
    
    var contentId: String { audiobookId }
    var contentName: String { name }
    var contentImageUrl: String { avatarUrl }
    
    enum CodingKeys: String, CodingKey {
        case audiobookId = "audiobook_id"
        case name
        case authorName = "author_name"
        case description
        case avatarUrl = "avatar_url"
        case duration, language
        case releaseDate = "release_date"
        case score
    }
}

struct AudioArticle: ContentItem {
    let articleId: String
    let name: String
    let authorName: String
    let description: String
    let avatarUrl: String
    let duration: Int
    let releaseDate: String
    let score: Double
    
    var contentId: String { articleId }
    var contentName: String { name }
    var contentImageUrl: String { avatarUrl }
    
    enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
        case name
        case authorName = "author_name"
        case description
        case avatarUrl = "avatar_url"
        case duration
        case releaseDate = "release_date"
        case score
    }
}

struct Pagination: Codable {
    let nextPage: String?
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
        case totalPages = "total_pages"
    }
}
