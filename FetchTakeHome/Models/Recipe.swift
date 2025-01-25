//
//  Recepie.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/19/25.
//

import Foundation

struct Recipe: Decodable {
    let uuid: String
    var cuisine: String
    var name: String
    var photoUrlLarge: String?
    var photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    var smallPhotoPath: String?
}
