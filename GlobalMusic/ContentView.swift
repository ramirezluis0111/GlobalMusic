//
//  ContentView.swift
//  GlobalMusic
//

import SwiftUI

struct ContentView: View {
    @State var results = [Result]()
    @State var searchedList = [Result]()
    @ObservedObject private var songs = DetailSongs()
    
    @State private var inputText: String = ""
    @State private var isEditing = false
    @State private var errorRequest = false
    @State private var pressSearch = false
    
    @ObservedObject var wordsSaved = SavedSeach()
    @State var words: [dataSaved]
    @State var image: UIImage
    
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
                                    self.endTextEditing()
                                    self.isEditing = false
                                    self.pressSearch = false
                                    self.inputText = ""
                                    searchedList.removeAll()
                                }) {
                                    Text("Cancel")
                                }
                                .font(.system(size: 18))
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
                                .font(.system(size: 18))
                                .padding(.trailing, 10)
                                .padding(.horizontal, 30)
                                .transition(.move(edge: .trailing))
                                .animation(.default)
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 35, alignment: .center)
                        }
                        

                        if !isEditing {
                            List {
                                ForEach(results, id: \.trackId) { item in
                                    CardsLibrary(collectionId: item.collectionId,
                                                 songs: songs,
                                                 selectedSong: item, image: UIImage())
                                }
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        } else {
                            if pressSearch {
                                List {
                                    ForEach(searchedList, id: \.trackId) { item in
                                        CardsLibrary(
                                                     collectionId: item.collectionId,
                                                     songs: songs,
                                                     selectedSong: item, image: UIImage())
                                    }
                                }
                            }
                        }
                        
                        if isEditing && !pressSearch {
                            List(words, id: \.id) { item in
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
                        Spacer()
                    }
                    .navigationBarTitle("GlobalMusic")
                }
            }
        }
        .onAppear{
            loadData()
            initWordsSuggestions()
        }
    }
    
    func initWordsSuggestions() {
        for item in self.wordsSaved.wordsSearched {
            words.append(dataSaved(dataString: item))
        }
    }
    
    func saveData() {
        if !self.wordsSaved.wordsSearched.map({$0.uppercased()}).contains(inputText.uppercased()) {
            self.wordsSaved.wordsSearched.append(inputText)
            words.append(dataSaved(dataString: inputText))
        }
    }
    
    func searchFilter(searched: String, data: [Result]) {
        let seached: [Result] = results.filter({ searched.isEmpty ? true :
                        $0.trackName!.uppercased().contains(searched.uppercased())
        })
        print(seached)
        searchedList = seached
    }
    
    func loadData() {
        guard let url = URL( string: "https://itunes.apple.com/search?term=*&mediaType=music&limit=40"
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
                                self.songs.appendAllSongs(listAppend: self.results)
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
        ContentView(words: [dataSaved](), image: UIImage())
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
