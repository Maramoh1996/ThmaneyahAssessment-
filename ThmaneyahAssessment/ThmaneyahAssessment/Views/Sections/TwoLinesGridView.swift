//
//  TwoLinesGridView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation
import SwiftUI

struct TwoLinesGridView: View {
    let items: [any ContentItem]
    let contentType: Section.ContentType
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: columns, spacing: 16) {
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
            PodcastGridCard(podcast: podcast)
        case let episode as Episode:
            EpisodeGridCard(episode: episode)
        case let audioBook as AudioBook:
            AudioBookGridCard(audioBook: audioBook)
        case let article as AudioArticle:
            AudioArticleGridCard(article: article)
        default:
            EmptyView()
        }
    }
}
