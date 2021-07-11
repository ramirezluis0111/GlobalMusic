//
//  ListAlbumSongs.swift
//  GlobalMusic
//

import SwiftUI

struct ListAlbumSongs: View {
    @State var results = [Result]()
    @State var collectionId: Int
    
    @ObservedObject var songs: DetailSongs
    
    var body: some View {
        List(results.dropFirst(), id: \.trackId) { item in
            HStack {
                Text(item.trackName!)
                    .padding()
                    .onTapGesture {
                        songs.selectSong(input: item)
                    }
                Spacer()
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL( string: "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song&mediaType=music"
        ) else {
            print("Invalid Url")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let decodeResponse = try?
                    JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodeResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}

struct ListAlbumSongs_Previews: PreviewProvider {
    static var previews: some View {
        ListAlbumSongs(collectionId: Int(), songs: DetailSongs())
    }
}
