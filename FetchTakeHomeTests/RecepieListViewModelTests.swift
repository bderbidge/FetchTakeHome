//
//  RecepieListViewModelTests.swift
//  FetchTakeHomeTests
//
//  Created by Brandon Derbidge on 1/20/25.
//

import Testing
@testable import FetchTakeHome
import Foundation

struct RecepieListViewModelTests {

    @Test func testSuccesfulLoad() async throws {
        // Arrange
        let mockRepo = MockRecepieRepository(fetchResult: .success([
            Recipe(uuid: "1", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small.jpg", sourceUrl: nil, youtubeUrl: nil),
            Recipe(uuid: "2", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small.jpg", sourceUrl: nil, youtubeUrl: nil)
        ]))
        let viewModel = RecepieListViewModel(repo: mockRepo)

        // Act
        await viewModel.load()

        // Assert
        #expect(viewModel.recepies?.count == 2)
        #expect(viewModel.recepies?.first?.uuid == "1")
        #expect(viewModel.showAlert == false)
    }
    
    @Test func testEmptyLoad() async throws {
        // Arrange
        let mockRepo = MockRecepieRepository(fetchResult: .success([]))
        let viewModel = RecepieListViewModel(repo: mockRepo)

        // Act
        await viewModel.load()

        // Assert
        #expect(viewModel.recepies?.count == 0)
        #expect(viewModel.showAlert == false)
    }
    
    @Test func testMalformedLoad() async throws {
        // Arrange
        let mockRepo = MockRecepieRepository(fetchResult: .failure(NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Malformed data"])))
        let viewModel = RecepieListViewModel(repo: mockRepo)

        // Act
        await viewModel.load()

        // Assert
        #expect(viewModel.recepies?.count == 0)
        #expect(viewModel.showAlert == true)
        #expect(viewModel.bannerData.detail == "Malformed data")
    }
    
    @Test func testSaveImageToDisk() async throws {
        // Arrange
        let recipe = Recipe(uuid: "1", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small.jpg", sourceUrl: nil, youtubeUrl: nil)
        let mockRepo = MockRecepieRepository(
            fetchResult: .success([recipe]),
            saveImageResult: "path/to/image.jpg"
        )
        let viewModel = RecepieListViewModel(repo: mockRepo)

        await viewModel.load()

        // Act
        await viewModel.saveImageToDisk(recepie: recipe)

        // Assert
        #expect(viewModel.recepies?.first?.smallPhotoPath == "path/to/image.jpg")
    }

}

