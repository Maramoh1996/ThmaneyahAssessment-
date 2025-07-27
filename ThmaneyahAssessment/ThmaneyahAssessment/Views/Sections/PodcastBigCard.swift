//
//  PodcastBigCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//
import SwiftUI

struct PodcastBigCard: View {
    let podcast: Podcast
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: podcast.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 250, height: 250)
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(podcast.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(podcast.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                HStack {
                    Label("\(podcast.episodeCount)", systemImage: "list.bullet")
                    Spacer()
                    if let score = podcast.popularityScore {
                        Label("\(score)", systemImage: "star.fill")
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: 250)
        }
        .frame(width: 250)
    }
}
