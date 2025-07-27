//
//  AudioBookSquareCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import SwiftUI

struct AudioBookSquareCard: View {
    let audioBook: AudioBook
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: audioBook.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 150, height: 150)
            .cornerRadius(12)
            
            Text(audioBook.name)
                .font(.headline)
                .lineLimit(1)
                .frame(maxWidth: 150, alignment: .leading)
            
            Text(audioBook.authorName)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(width: 150)
    }
}
