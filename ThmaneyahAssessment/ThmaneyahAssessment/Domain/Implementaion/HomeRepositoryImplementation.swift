//
//  HomeRepositoryImplementation.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation

class HomeRepositoryImplementation: HomeRepositoryProtocol {
    
    func fetchHomeSections() async throws -> HomeResponse {
        guard let url = Bundle.main.url(forResource: "sections", withExtension: "json") else {
            throw RepositoryError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(HomeResponse.self, from: data)
        } catch {
            print("Error details: \(error)")
            throw RepositoryError.decodingError(error)
        }
    }
}

// MARK: - Repository Errors
enum RepositoryError: LocalizedError {
    case fileNotFound
    case fileLoadError(Error)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "JSON file not found in bundle"
        case .fileLoadError(let error):
            return "Failed to load file: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode JSON: \(error.localizedDescription)"
        }
    }
}
