//
//  MockRecepieRepository.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/20/25.
//
@testable import FetchTakeHome

struct MockRecepieRepository: RecepieRepository {
    var fetchResult: Result<[Recipe], Error>
    var saveImageResult: String? = nil

    func fetchRecepies() async throws -> [Recipe] {
        switch fetchResult {
        case .success(let recepies):
            return recepies
        case .failure(let error):
            throw error
        }
    }

    func saveSmallImage(recepie: Recipe) async -> String? {
        return saveImageResult
    }
}
