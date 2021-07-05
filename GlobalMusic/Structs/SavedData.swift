//
//  SavedData.swift
//  GlobalMusic
//
//  Created by Ramirez Luis on 04/07/2021.
//

import Foundation

class SavedSeach: ObservableObject {
    @Published var wordsSearched = UserDefaults.standard.stringArray(forKey: "searched") ?? [String]() {
        didSet {
            UserDefaults.standard.set(self.wordsSearched, forKey: "searched")
        }
    }
}
