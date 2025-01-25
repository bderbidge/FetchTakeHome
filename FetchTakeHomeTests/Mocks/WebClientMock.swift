//
//  WebClientMock.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/20/25.
//

@testable import FetchTakeHome
import Foundation

final class WebClientMock: WebClient {
    var getDataResult: Data?
    var fetchResult: FetchRecepies?
    
    func getData(from url: URL) async throws -> Data {
        guard let result = getDataResult else {
            throw NetworkError.invalidResponse
        }
        return result
    }
    
    func fetch<T>(url: URL) async throws -> T where T : Decodable {
        guard let result = fetchResult as? T else {
            throw NetworkError.invalidResponse
        }
        return result
    }
}

