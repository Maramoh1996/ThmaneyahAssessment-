//
//  SquareLayoutView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation
import SwiftUI

struct SquareLayoutView: View {
    let items: [any ContentItem]
    let contentType: Section.ContentType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(items, id: \.contentId) { item in
                    contentView(for: item)
                }
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func contentView(for item: any ContentItem) -> some View {
        switch item {
        case let podcast as Podcast:
            PodcastSquareCard(podcast: podcast)
        case let episode as Episode:
            EpisodeSquareCard(episode: episode)
        case let audioBook as AudioBook:
            AudioBookSquareCard(audioBook: audioBook)
        case let article as AudioArticle:
            AudioArticleSquareCard(article: article)
        default:
            EmptyView()
        }
    }
}
