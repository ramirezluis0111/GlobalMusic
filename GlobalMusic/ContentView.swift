//
//  ContentView.swift
//  GlobalMusic
//

import SwiftUI

struct ContentView: View {
    @State var results = [Result]()
    @State var searchedList = [Result]()
    
    @State private var inputText: String = ""
    @State private var isEditing = false
    @State private var errorRequest = false
    @State private var pressSearch = false
    
    @ObservedObject var wordsSaved = SavedSeach()
    @State var words: [dataSaved]
    
    var body: some View {

        ZStack {
            if errorRequest {
                AlertConectionView()
            } else {
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
                                self.pressSearch = false
                            }
                            .onChange(of: inputText, perform: { value in
                                if value.isEmpty {
                                    isEditing = false
                                }
                            })
                        
                        if isEditing {
                            HStack {
                                Button(action: {
                                    searchedList.removeAll()
                                    self.endTextEditing()
                                    self.isEditing = false
                                    self.pressSearch = false
                                    self.inputText = ""
                                }) {
                                    Text("Cancel")
                                }
                                .padding(.trailing, 10)
                                .padding(.horizontal, 30)
                                .transition(.move(edge: .trailing))
                                .animation(.default)
                                
                                Button(action: {
                                    searchFilter(searched: inputText, data: results)
                                    !inputText.isEmpty ? saveData() : print("")
                                    self.endTextEditing()
                                    self.pressSearch = true
                                }) {
                                    Text("Search")
                                }
                                .padding(.trailing, 10)
                                .padding(.horizontal, 30)
                                .transition(.move(edge: .trailing))
                                .animation(.default)
                            }
                        }
                        
                        ScrollView {
                            LazyVStack {
                                if !isEditing {
                                    ForEach(results, id: \.trackId) { item in
                                        CardsLibrary(trackName: item.trackName!,
                                                     collectionName: item.collectionName!,
                                                     artistName: item.artistName!,
                                                     artworkUrl100: item.artworkUrl100!,
                                                     previewUrl: item.previewUrl!,
                                                     collectionId: item.collectionId)
                                    }
                                    
                                } else {
                                    if pressSearch {
                                        ForEach(searchedList, id: \.trackId) { item in
                                            CardsLibrary(trackName: item.trackName!,
                                                         collectionName: item.collectionName!,
                                                         artistName: item.artistName!,
                                                         artworkUrl100: item.artworkUrl100!,
                                                         previewUrl: item.previewUrl!,
                                                         collectionId: item.collectionId)
                                        }
                                    } else {
                                        ForEach(words, id: \.id) { item in
                                            Text(item.dataString)
                                                .padding(5)
                                                .onTapGesture {
                                                    self.isEditing = true
                                                    self.pressSearch = true
                                                    searchFilter(searched: item.dataString, data: results)
                                                    self.endTextEditing()
                                                }
                                        }
                                    }
                                }
                            }
                        }
                        .navigationBarTitle("GlobalMusic")
                    }
                }
            }
        }
        .onAppear{
            loadData()
            for item in self.wordsSaved.wordsSearched {
                words.append(dataSaved(dataString: item))
            }
        }
    }
    
    func saveData() {
        self.wordsSaved.wordsSearched.append(inputText)
    }
    
    func searchFilter(searched: String, data: [Result]) {
        let seached: [Result] = results.filter({ searched.isEmpty ? true :
                        $0.trackName!.uppercased().contains(searched.uppercased())
        })
        searchedList = seached
    }
    
    func loadData() {
        guard let url = URL( string: "https://itunes.apple.com/search?term=in+utero&mediaType=music&limit=20"
        ) else {
            print("Invalid Url")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                    case 500...599:
                        print("We have one drawback")
                        errorRequest = true
                    default:
                        if let decodeResponse = try?
                            JSONDecoder().decode(Response.self, from: data) {
                            DispatchQueue.main.async {
                                self.results = decodeResponse.results
                            }
                            return
                        }
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(words: [dataSaved]())
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
