//
//  ThmaneyahAssessmentTests.swift
//  ThmaneyahAssessmentTests
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import Testing
import XCTest
@testable import ThmaneyahAssessment


class HomeRepositoryTests: XCTestCase {
    
    var sut: HomeRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        sut = HomeRepositoryImplementation()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchHomeSections_WithValidJSON_ReturnsHomeResponse() async throws {
        // When
        let response = try await sut.fetchHomeSections()
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertGreaterThan(response.sections.count, 0)
        XCTAssertNotNil(response.pagination)
    }
    
    func testFetchHomeSections_ParsesSectionsCorrectly() async throws {
        // When
        let response = try await sut.fetchHomeSections()
        
        // Then
        let firstSection = response.sections.first
        XCTAssertNotNil(firstSection)
        XCTAssertNotNil(firstSection?.name)
        XCTAssertNotNil(firstSection?.type)
        XCTAssertNotNil(firstSection?.contentType)
        XCTAssertGreaterThan(firstSection?.content.count ?? 0, 0)
    }
    
    func testFetchHomeSections_ParsesContentItemsCorrectly() async throws {
        // When
        let response = try await sut.fetchHomeSections()
        
        // Then
        let podcastSection = response.sections.first { $0.contentType == .podcast }
        XCTAssertNotNil(podcastSection)
        
        if let firstPodcast = podcastSection?.content.first as? Podcast {
            XCTAssertNotNil(firstPodcast.podcastId)
            XCTAssertNotNil(firstPodcast.name)
            XCTAssertNotNil(firstPodcast.description)
            XCTAssertNotNil(firstPodcast.avatarUrl)
        } else {
            XCTFail("First content item should be a Podcast")
        }
    }
    
    
    // MARK: - Performance Tests
    
    func testFetchHomeSections_Performance() {
        measure {
            let expectation = XCTestExpectation(description: "Fetch sections")
            
            Task {
                do {
                    _ = try await sut.fetchHomeSections()
                    expectation.fulfill()
                } catch {
                    XCTFail("Performance test failed: \(error)")
                }
            }
            wait(for: [expectation], timeout: 1.0)
        }
    }
}
