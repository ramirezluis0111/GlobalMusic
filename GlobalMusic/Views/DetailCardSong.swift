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
    @State var artworkUrl100: String
    @State var previewUrl: String

    var body: some View {
        ZStack {
            Color.init(hexStringToUIColor(hex: "#D6D6D6"))
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
                    .animation(Animation.easeOut(duration: 0.6).delay(0.2))
                    
                    Text(trackName)
                        .font(.system(size: 25))
                        .bold()
                        .padding(5)
                        .animation(Animation.easeOut.delay(0.4))
                    Text(collectionName)
                        .font(.system(size: 18))
                        .animation(Animation.easeOut.delay(0.6))
                }
                .padding()
                
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "backward.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                    })
                
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

                    Button(action: {}, label: {
                        Image(systemName: "forward.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                    })
                }
                .animation(Animation.easeOut.delay(0.8))
            }
            
            
        }
        .clipped()
        .ignoresSafeArea(.all)
        .opacity(0.9)
        .onAppear {
            loadTrack(radioURL: previewUrl)
        }
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
                       artworkUrl100: String(),
                       previewUrl: String())
    }
}
