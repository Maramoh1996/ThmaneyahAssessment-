//
//  SectionView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation
import SwiftUI

struct SectionView: View {
    let section: Section
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(section.name)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            sectionContent
        }
    }
    
    @ViewBuilder
    var sectionContent: some View {
        switch section.type {
        case .square:
            SquareLayoutView(items: section.content, contentType: section.contentType)
        case .twoLinesGrid:
            TwoLinesGridView(items: section.content, contentType: section.contentType)
        case .bigSquare:
            BigSquareLayoutView(items: section.content, contentType: section.contentType)
        case .queue:
            QueueLayoutView(items: section.content, contentType: section.contentType)
        case .bigSquareSpace:
            BigSquareLayoutView(items: section.content, contentType: section.contentType)
        }
    }
}
