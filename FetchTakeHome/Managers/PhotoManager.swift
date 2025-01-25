//
//  DataClient.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/19/25.
//

import Foundation

protocol PhotoManager {
    func photoPathExists(path: String?) throws -> Bool
    func savePhoto(path: String, fileContent: Data) throws
    func pathOnDisk(path: String) throws -> String?
}

struct ClientPhotoManager: PhotoManager {
    let fileManager = FileManager.default
    func photoPathExists(path: String?) throws -> Bool {
        guard let path else { return false }
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ClientError.cannontReadFromDisk
        }
        let file = directory.appendingPathComponent(path)
        return fileManager.fileExists(atPath: file.path)
    }
    
    func savePhoto(path: String, fileContent: Data) throws {
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ClientError.cannontWriteToDisk
        }
        let file = directory.appendingPathComponent(path)
        let folder = file.deletingLastPathComponent()
        if try !photoPathExists(path: folder.path()) {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
        }
        try fileContent.write(to: file)
    }
    
    func pathOnDisk(path: String) throws -> String? {
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ClientError.cannontReadFromDisk
        }
        let file = directory.appendingPathComponent(path)
        return file.path()
    }
}

enum ClientError: Error {
    case cannontWriteToDisk
    case cannontReadFromDisk
}
