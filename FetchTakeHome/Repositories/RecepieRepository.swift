//
//  RecepieRepository.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/19/25.
//

import Foundation
import OSLog

protocol RecepieRepository {
    func fetchRecepies() async throws -> [Recipe]
    func saveSmallImage(recepie: Recipe) async -> String?
}

struct RecepieRepositoryImp: RecepieRepository {
    let webClient: WebClient
    let photoManager: PhotoManager
    let logger: Logger
    let baseUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    let malformed = "recipes-malformed.json"
    let recepies = "recipes.json"
    let empty = "recipes-empty.json"
    
    func saveSmallImage(recepie: Recipe) async -> String? {
        do {
            guard recepie.smallPhotoPath == nil,
                  let smallImage = smallPhotoPath(recipe: recepie),
                  try !photoManager.photoPathExists(path: smallImage) else  {
                logger.error("photo already exists")
                return nil
            }
            
            guard let url = recepie.photoUrlSmall, let smallUrl = URL(string: url) else {
                logger.error("invalid url")
                return nil
            }
            
            let smallData = try await webClient.getData(from: smallUrl)
            try photoManager.savePhoto(path: smallImage, fileContent: smallData)
            return try photoManager.pathOnDisk(path: smallImage)
        } catch {
            logger.error("\(error)")
            return nil
        }
    }
    
    func fetchRecepies() async throws -> [Recipe] {
        guard let url = URL(string: baseUrl + recepies) else {
            throw NetworkError.invalidUrl
        }
        let response: FetchRecepies = try await webClient.fetch(url: url)
        var recipes = response.recipes
        for index in recipes.indices {
            
            if let photo = smallPhotoPath(recipe: recipes[index]),  try photoManager.photoPathExists(path: photo) {
                recipes[index].smallPhotoPath = try photoManager.pathOnDisk(path: photo)
            }
        }
        return recipes
    }
    
    private func smallPhotoPath(recipe: Recipe) -> String? {
        guard let url = recipe.photoUrlSmall, let range = url.range(of: "photos") else {
            logger.error("invalid url format")
            return nil
        }
        return String(url[range.lowerBound...])
    }
}

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
}
