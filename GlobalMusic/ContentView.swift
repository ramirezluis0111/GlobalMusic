//
//  ContentView.swift
//  GlobalMusic
//

import SwiftUI

struct Result: Codable {
    let trackId: Int
    let trackName: String
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let previewUrl: String
    let collectionId: Int
}

struct Response: Codable {
    let results: [Result]
}

struct ContentView: View {
    @State var results = [Result]()
    @State private var inputText: String = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search..", text: $inputText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.inputText = ""

                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
                
                ScrollView {
                    LazyVStack {
                        ForEach(results.filter({ inputText.isEmpty ? true :
                            $0.trackName.uppercased().contains(inputText.uppercased())
                        }), id: \.trackId) { item in
                            CardsLibrary(trackName: item.trackName,
                                         collectionName: item.collectionName,
                                         artistName: item.artistName,
                                         artworkUrl100: item.artworkUrl100,
                                         previewUrl: item.previewUrl,
                                         collectionId: item.collectionId)
                        }
                    }
                }
                .navigationBarTitle("GlobalMusic")
            }
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
