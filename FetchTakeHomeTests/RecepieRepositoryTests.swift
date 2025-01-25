//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Brandon Derbidge on 1/19/25.
//

import Testing
@testable import FetchTakeHome
import Foundation

struct RecepieRepositoryTests {

    @Test func testSaveSmallImage_success() async {
        // Arrange
        let photoManagerMock = PhotoManagerMock()
        let webClientMock = WebClientMock()
        let repository = RecepieRepositoryImp(webClient: webClientMock, photoManager: photoManagerMock)
        let recipe = Recipe(uuid: "", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small.jpg", sourceUrl: nil, youtubeUrl: nil)
        photoManagerMock.photoPathExistsResult = false
        webClientMock.getDataResult = Data([0x01, 0x02, 0x03])
        photoManagerMock.savePhotoResult = nil
        photoManagerMock.smallPhotoPathResult = "local/photos/small.jpg"
        
        // Act
        let result = await repository.saveSmallImage(recepie: recipe)
        
        // Assert
        #expect(result == "local/photos/small.jpg")
        #expect(photoManagerMock.savedPhotoPath == "photos/small.jpg")
        #expect(photoManagerMock.savedPhotoContent == Data([0x01, 0x02, 0x03]))
    }
    
    @Test func testSaveSmallImage_photoAlreadyExists() async {
        // Arrange
        let photoManagerMock = PhotoManagerMock()
        let webClientMock = WebClientMock()
        let repository = RecepieRepositoryImp(webClient: webClientMock, photoManager: photoManagerMock)
        let recipe = Recipe(uuid: "", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small.jpg", sourceUrl: nil, youtubeUrl: nil)
        photoManagerMock.photoPathExistsResult = true
        
        // Act
        let result = await repository.saveSmallImage(recepie: recipe)
        
        // Assert
        #expect(result == nil)
    }
    
    @Test func testSaveSmallImage_invalidUrl() async {
        // Arrange
        let photoManagerMock = PhotoManagerMock()
        let webClientMock = WebClientMock()
        let repository = RecepieRepositoryImp(webClient: webClientMock, photoManager: photoManagerMock)
        let recipe = Recipe(uuid: "", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small.jpg", sourceUrl: nil, youtubeUrl: nil)
        
        // Act
        let result = await repository.saveSmallImage(recepie: recipe)
        
        // Assert
        #expect(result == nil)
    }
    
    @Test func testFetchRecepies_success() async throws {
        // Arrange
        let photoManagerMock = PhotoManagerMock()
        let webClientMock = WebClientMock()
        let repository = RecepieRepositoryImp(webClient: webClientMock, photoManager: photoManagerMock)
        let recipe = Recipe(uuid: "", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small.jpg", sourceUrl: nil, youtubeUrl: nil)
        let recipe2 = Recipe(uuid: "", cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "https://example.com/photos/small2.jpg", sourceUrl: nil, youtubeUrl: nil)
        
        let mockResponse = FetchRecepies(recipes: [
            recipe,
            recipe2
        ])
        webClientMock.fetchResult = mockResponse
        photoManagerMock.photoPathExistsResult = true
        photoManagerMock.smallPhotoPathResult = "local/photos/small1.jpg"
        
        // Act
        let recipes = try await repository.fetchRecepies()
        
        // Assert
        #expect(recipes.count == 2)
        #expect(recipes[0].smallPhotoPath == "local/photos/small1.jpg")
    }

}
