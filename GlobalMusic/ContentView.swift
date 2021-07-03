//
//  ContentView.swift
//  GlobalMusic
//

import SwiftUI

struct Result: Codable {
    let trackId: Int
    let trackName: String
    let collectionName: String
    let artworkUrl100: String
    let previewUrl: String
}

struct Response: Codable {
    let results: [Result]
}

struct ContentView: View {
    @State var results = [Result]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(results, id: \.trackId) { item in
                        CardsLibrary(trackName: item.trackName,
                                     collectionName: item.collectionName,
                                     artworkUrl100: item.artworkUrl100,
                                     previewUrl: item.previewUrl)
                    }
                }
            }
            .navigationBarTitle("GlobalMusic")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL( string: "https://itunes.apple.com/search?term=in+utero&mediaType=music&limit=20"
        ) else {
            print("Invalid Url")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
