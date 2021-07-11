//
//  DetailCardSong.swift
//  GlobalMusic
//

import SwiftUI
import AVKit

struct DetailCardSong: View {
    @Environment(\.colorScheme) var colorScheme
    @State var playerTrack: AVPlayer!
    @State var played = false
    
    @State var collectionId: Int
    
    @ObservedObject var songs: DetailSongs
    @State var imageSelect: UIImage

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    VStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 13)
                                .frame(width: 110,
                                       height: 110,
                                       alignment: .center)
                                .foregroundColor(Color.white)
                            
                            Image(uiImage: collectionId != songs.songSelect["collectionId"] as! Int ?
                                    InitImage(url: (songs.songSelect["artworkUrl100"] as? String)!)
                                    : imageSelect)
                                        .cornerRadius(10)
                                        .padding(10)
                                        .onChange(of: (songs.songSelect["trackName"] as? String)!, perform: { value in
                                            initImage()
                                        })
                        }
                        .animation(Animation.easeOut(duration: 0.6).delay(0.4))
                        
                        VStack {
                            Text((songs.songSelect["trackName"] as? String)!)
                                .font(.system(size: 23))
                                .bold()
                                .onChange(of: (songs.songSelect["trackName"] as? String)!, perform: { value in
                                    loadTrack(radioURL: (songs.songSelect["previewUrl"] as? String)!)
                                    play()
                                    played = true
                                })
                            Text((songs.songSelect["collectionName"] as? String)!)
                                .font(.system(size: 16))
                            Text((songs.songSelect["artistName"] as? String)!)
                                .font(.system(size: 16))
                                .bold()
                                .padding(3)
                        }
                        .animation(Animation.easeOut(duration: 0.6).delay(0.6))
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
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .font(.system(size: 50))
                        })
                    }
                    .animation(Animation.easeOut(duration: 0.6).delay(0.8))
                }
                .frame(height: UIScreen.main.bounds.height / 2.3,
                       alignment: .bottom)
                .padding(.top, 18)
                
                
                ListAlbumSongs(collectionId: collectionId, songs: songs)
                    .animation(Animation.easeOut)
            }
        }
        .clipped()
        .ignoresSafeArea(.all)
        .transition(.scale).animation(.easeOut(duration: 1.6))
        .onAppear{
            collectionId = 0
        }
        .onDisappear{
            playerTrack?.pause()
        }
    }
    
    func loadTrack(radioURL: String) {
        guard let url = URL.init(string: radioURL) else { return }
        
        if playerTrack != nil {
            playerTrack.replaceCurrentItem(with: AVPlayerItem.init(url: url))
        }
        let playerItem = AVPlayerItem.init(url: url)
        playerTrack = AVPlayer.init(playerItem: playerItem)
    }
    
    func play() {
        playerTrack?.pause()
        playerTrack?.play()
    }

    func pause() {
        playerTrack?.pause()
    }
    
    func initImage() {
        if collectionId != songs.songSelect["collectionId"] as! Int {
            imageSelect = InitImage(url: (songs.songSelect["artworkUrl100"] as? String)!)
            collectionId = songs.songSelect["collectionId"] as! Int
        }
    }
}

struct DetailCardSong_Previews: PreviewProvider {
    static var previews: some View {
        DetailCardSong(collectionId: Int(),
                       songs: DetailSongs(),
                       imageSelect: UIImage())
    }
}
