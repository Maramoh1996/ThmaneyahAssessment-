//
//  AudioBookGridCard.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//
import SwiftUI

struct AudioBookGridCard: View {
    let audioBook: AudioBook
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: audioBook.avatarUrl)) { image in
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
                Text(audioBook.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                Text(audioBook.authorName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text(FormatHelper.duration(audioBook.duration))
                    .font(.caption2)
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
