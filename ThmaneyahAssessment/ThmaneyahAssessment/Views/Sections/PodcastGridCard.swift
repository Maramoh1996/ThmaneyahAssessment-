//
//  PodcastGridCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import SwiftUI

struct PodcastGridCard: View {
    let podcast: Podcast
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: podcast.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(podcast.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                Text("\(podcast.episodeCount) episodes")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .frame(width: 200)
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
