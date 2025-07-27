//
//  BigSquareLayoutView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation
import SwiftUI

struct BigSquareLayoutView: View {
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
            PodcastBigCard(podcast: podcast)
        case let episode as Episode:
            EpisodeBigCard(episode: episode)
        case let audioBook as AudioBook:
            AudioBookBigCard(audioBook: audioBook)
        case let article as AudioArticle:
            AudioArticleBigCard(article: article)
        default:
            EmptyView()
        }
    }
}
