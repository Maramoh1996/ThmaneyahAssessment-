//
//  AudioBookBigCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import SwiftUI

struct AudioBookBigCard: View {
    let audioBook: AudioBook
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: audioBook.avatarUrl)) { image in
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
                Text(audioBook.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text("by \(audioBook.authorName)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(audioBook.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                Text(FormatHelper.duration(audioBook.duration))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: 250)
        }
        .frame(width: 250)
    }
}
