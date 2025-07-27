//
//  EpisodeBigCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//
import SwiftUI

struct EpisodeBigCard: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: episode.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 250, height: 250)
            .cornerRadius(16)
            .overlay(
                // Play button overlay
                Circle()
                    .fill(Color.black.opacity(0.7))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    )
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(episode.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(episode.podcastName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text(FormatHelper.duration(episode.duration))
                    Spacer()
                    Text(FormatHelper.date(episode.releaseDate))
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: 250)
        }
        .frame(width: 250)
    }
}
