//
//  PodcastSquareCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation
import SwiftUI

struct PodcastSquareCard: View {
    let podcast: Podcast
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: podcast.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 150, height: 150)
            .cornerRadius(12)
            
            Text(podcast.name)
                .font(.headline)
                .lineLimit(1)
                .frame(maxWidth: 150, alignment: .leading)
            
            Text("\(podcast.episodeCount) episodes")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 150)
    }
}
