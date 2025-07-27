//
//  HomeViewModel.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var sections: [Section] = []
    @Published var isLoading = false
    @Published var error: Error?

    private let repository: HomeRepositoryProtocol

    init() {
        self.repository = HomeRepositoryImplementation()
    }

    func loadHomeSections() async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.error = nil
        }

        do {
            let response = try await repository.fetchHomeSections()
            DispatchQueue.main.async {
                self.sections = response.sections.sorted { $0.order < $1.order }
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error
                self.isLoading = false
            }
            print("Error loading sections: \(error)")
        }
    }
}
