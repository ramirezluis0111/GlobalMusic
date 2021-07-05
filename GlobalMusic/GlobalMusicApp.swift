//
//  GlobalMusicApp.swift
//  GlobalMusic
//

import SwiftUI

@main
struct GlobalMusicApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(words: [dataSaved]())
        }
    }
}
