//
//  QueueLayoutView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation
import SwiftUI

struct QueueLayoutView: View {
    let items: [any ContentItem]
    let contentType: Section.ContentType
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(items.prefix(3), id: \.contentId) { item in
                HStack {
                    AsyncImage(url: URL(string: item.contentImageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(item.contentName)
                            .font(.headline)
                            .lineLimit(1)
                        
                        if let episode = item as? Episode {
                            Text(episode.podcastName)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
        }
    }
}
