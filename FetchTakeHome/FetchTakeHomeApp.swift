//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/19/25.
//

import SwiftUI
import OSLog

@main
struct FetchTakeHomeApp: App {
    let logger = Logger(subsystem: "com.example.yourapp", category: "networking")
    var body: some Scene {
        WindowGroup {
            RecepieListView(viewModel: .init(repo: RecepieRepositoryImp(webClient: WebClientImp(), photoManager: ClientPhotoManager())))
        }
    }
}
