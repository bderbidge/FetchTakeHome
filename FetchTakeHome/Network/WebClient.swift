//
//  NetworkingClient.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/19/25.
//

import Foundation

protocol WebClient {
    func fetch<FetchResponse: Decodable>(url: URL) async throws -> FetchResponse
    func getData(from url: URL) async throws -> Data 
}

struct WebClientImp: WebClient {
    func fetch<FetchResponse: Decodable>(url: URL) async throws -> FetchResponse {
        let data = try await getData(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(FetchResponse.self, from: data)
        return decodedResponse
    }
    
    func getData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
