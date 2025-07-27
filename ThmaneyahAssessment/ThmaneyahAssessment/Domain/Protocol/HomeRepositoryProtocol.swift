//
//  HomeRepositoryProtocol.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 27/07/2025.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchHomeSections() async throws -> HomeResponse
}
