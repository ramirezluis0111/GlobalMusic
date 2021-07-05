//
//  StructResponse.swift
//  GlobalMusic
//
//  Created by Ramirez Luis on 04/07/2021.
//

import Foundation

struct Result: Codable {
    let trackId : Int?
    let trackName: String?
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: String?
    let previewUrl: String?
    let collectionId: Int
}

struct Response: Codable {
    let resultCount: Int
    let results: [Result]
}
