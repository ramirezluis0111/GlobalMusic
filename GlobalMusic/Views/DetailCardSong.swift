//
//  DetailCardSong.swift
//  GlobalMusic
//

import SwiftUI
import AVKit

struct DetailCardSong: View {
    @State var playerTrack: AVPlayer!
    @State var played = false
    
    @State var trackName: String
    @State var collectionName: String
    @State var artistName: String
    @State var artworkUrl100: String
    @State var previewUrl: String
    @State var collectionId: Int

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 13)
                                .frame(width: 110,
                                       height: 110,
                                       alignment: .center)
                                .foregroundColor(Color.white)
                            
                            Image(uiImage: InitImage(url: artworkUrl100))
                                    .cornerRadius(10)
                                    .padding(10)
                        }
                        .animation(Animation.easeInOut(duration: 0.6).delay(1.2))
                        
                        VStack {
                            Text(trackName)
                                .font(.system(size: 23))
                                .bold()
                            Text(collectionName)
                                .font(.system(size: 16))
                            Text(artistName)
                                .font(.system(size: 16))
                                .bold()
                                .padding(3)
                        }
                        .animation(Animation.easeInOut(duration: 0.6).delay(1.4))
                    }
                    
                    HStack {
                        Button(action: {
                            if played {
                                played = false
                                pause()
                            } else {
                                played = true
                                play()
                            }
                        }, label: {
                            Image(systemName: !played ? "play.circle.fill"
                                    : "pause.circle.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 50))
                        })
                    }
                    .animation(Animation.easeInOut(duration: 0.6).delay(1.6))
                }
                .frame(height: UIScreen.main.bounds.height / 2.3,
                       alignment: .bottom)
                .padding()
                .animation(Animation.easeOut(duration: 0.5))
                
                ListAlbumSongs(collectionId: collectionId)
            }
        }
        .clipped()
        .ignoresSafeArea(.all)
        .onAppear {
            loadTrack(radioURL: previewUrl)
        }
        .transition(.scale).animation(.easeOut(duration: 1.6).delay(1.6))
    }
    
    func loadTrack(radioURL: String) {
        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        playerTrack = AVPlayer.init(playerItem: playerItem)
    }
    
    func play() {
        playerTrack?.play()
    }

    func pause() {
        playerTrack?.pause()
    }
}

struct DetailCardSong_Previews: PreviewProvider {
    static var previews: some View {
        DetailCardSong(trackName: String(),
                       collectionName: String(),
                       artistName: String(),
                       artworkUrl100: String(),
                       previewUrl: String(),
                       collectionId: Int())
    }
}
