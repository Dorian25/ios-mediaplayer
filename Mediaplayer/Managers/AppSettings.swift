//
//  AppSettings.swift
//  Mediaplayer
//
//  Created by dorian on 03/08/2022.
//

import Foundation

class AppSettings: ObservableObject {
    @Published var songs: [Song]
    init() {
        self.songs = []
    }
}
