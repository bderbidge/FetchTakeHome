//
//  RecepieListViewModel.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/20/25.
//

import Foundation
import OSLog

@Observable
class RecepieListViewModel {
    let repo: RecepieRepository
    let logger: Logger
    var recepies: [Recipe]?
    var showAlert = false
    var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "Error Fetching Data", detail: "", type: .Error)
    init(repo: RecepieRepository, logger: Logger) {
        self.repo = repo
        self.logger = logger
    }
    
    func load() async {
        do {
            recepies = try await repo.fetchRecepies()
        } catch {
            recepies = []
            bannerData.detail = error.localizedDescription
            showAlert = true
            logger.error("\(error)")
        }
    }
    
    func saveImageToDisk(recepie: Recipe) async {
        let imgPath = await repo.saveSmallImage(recepie: recepie)
        guard let index = recepies?.firstIndex(where: {$0.uuid == recepie.uuid}) else {
            logger.error("Recepie doesn't exist id: \(recepie.uuid)")
            return
        }
        recepies?[index].smallPhotoPath = imgPath
    }
}
