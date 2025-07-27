//
//  AudioArticleBigCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//
import SwiftUI

struct AudioArticleBigCard: View {
    let article: AudioArticle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: article.avatarUrl)) { image in
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
                Text(article.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text("by \(article.authorName)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(article.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                HStack {
                    Text(FormatHelper.duration(article.duration))
                    Spacer()
                    Text(FormatHelper.date(article.releaseDate))
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: 250)
        }
        .frame(width: 250)
    }
}
