//
//  CardsLibrary.swift
//  GlobalMusic
//

import SwiftUI
import AVKit

struct CardsLibrary: View {
    @State var trackName: String
    @State var collectionName: String
    @State var artistName: String
    @State var artworkUrl100: String
    @State var playerTrack: AVPlayer!
    @State var previewUrl: String
    @State var collectionId: Int
    
    var body: some View {
        NavigationLink(
            destination: DetailCardSong(playerTrack: playerTrack,
                                        trackName: trackName,
                                        collectionName: collectionName,
                                        artistName: artistName,
                                        artworkUrl100: artworkUrl100,
                                        previewUrl: previewUrl,
                                        collectionId: collectionId),
            label: {
                HStack() {
                    Image(uiImage: InitImage(url: artworkUrl100))
                        .cornerRadius(13)
                        .padding(10)
                    VStack(alignment: .leading) {
                        Text(trackName)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .bold()
                        Text(collectionName)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(artistName)
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
                .padding()
            })
    }
}

struct CardsLibrary_Previews: PreviewProvider {
    static var previews: some View {
        CardsLibrary(trackName: String(),
                     collectionName: String(),
                     artistName: String(),
                     artworkUrl100: String(),
                     previewUrl: String(),
                     collectionId: Int())
    }
}
