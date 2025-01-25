//
//  PhotoManagerMock.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/20/25.
//

@testable import FetchTakeHome
import Foundation

final class PhotoManagerMock: PhotoManager {
    var photoPathExistsResult: Bool = false
    var savePhotoResult: Error?
    var smallPhotoPathResult: String?
    
    var savedPhotoPath: String?
    var savedPhotoContent: Data?
    
    func photoPathExists(path: String?) throws -> Bool {
        return photoPathExistsResult
    }
    
    func savePhoto(path: String, fileContent: Data) throws {
        if let error = savePhotoResult {
            throw error
        }
        savedPhotoPath = path
        savedPhotoContent = fileContent
    }
    
    func pathOnDisk(path: String) throws -> String? {
        guard let result = smallPhotoPathResult else {
            throw NetworkError.invalidResponse
        }
        return result
    }
}
