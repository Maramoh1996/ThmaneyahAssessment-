//
//  ContentView.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            MainNavigationBarView()
            Color.gray.opacity(0)
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
        .environment(\.layoutDirection, .rightToLeft)
    }
}

#Preview {
    ContentView()
}
