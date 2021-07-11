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

class DetailSongs: ObservableObject {
    @Published var listSongs = [Result]()
    @Published var songSelect: [String: Any]
    
    init() {
        songSelect = ["trackId" : 0,
                      "trackName": "",
                      "artistName": "",
                      "collectionName": "",
                       "artworkUrl100": "",
                       "previewUrl": "",
                       "collectionId": 0,
            ]
    }
    
    func appendAllSongs(listAppend: [Result]) {
        listSongs = listAppend
    }
    
    func selectSong(input: Result) {
        songSelect = [
                    "trackId" : input.trackId!,
                       "trackName": input.trackName!,
                       "artistName": input.artistName!,
                       "collectionName": input.collectionName!,
                       "artworkUrl100": input.artworkUrl100!,
                       "previewUrl": input.previewUrl!,
                       "collectionId": input.collectionId,
            ] as [String: Any]
    }
    
    func selectWithTrackId(trackId: Int) {
        print("AAA")
    }
}
