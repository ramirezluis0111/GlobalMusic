//
//  StructResponse.swift
//  GlobalMusic
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

struct dataSaved: Identifiable {
    var id =  UUID()
    var dataString: String
}
