//
//  CardsLibrary.swift
//  GlobalMusic
//

import SwiftUI
import AVKit

struct CardsLibrary: View {
    @State var collectionId: Int
    
    @ObservedObject var songs: DetailSongs
    @State var selectedSong: Result
    @State var image: UIImage
    @State var trackName1 = ""
    
    var body: some View {
        NavigationLink(
            destination:
                withAnimation{
                    DetailCardSong(collectionId: collectionId,
                                   songs: songs, imageSelect: UIImage())
                        .onAppear{
                            songs.selectSong(input: selectedSong)
                        }
                },
            label: {
                HStack() {
                    Image(uiImage: image)
                        .cornerRadius(13)
                        .padding(10)
                        .onAppear{
                            if trackName1 != selectedSong.trackName! {
                                trackName1 = selectedSong.trackName!
                                image = InitImage(url: selectedSong.artworkUrl100!)
                            }
                        }
                    VStack(alignment: .leading) {
                        Text(selectedSong.trackName!)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .bold()
                        Text(selectedSong.collectionName!)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(selectedSong.artistName!)
                            .font(.system(size: 12))
                            .bold()
                            .foregroundColor(.gray)
                            .padding(3)
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 1.3, height: 120, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.init(hexStringToUIColor(hex: "#D6D6D6")),
                        radius: 8, x: 0.0, y: 0.0)
            })
    }
}
