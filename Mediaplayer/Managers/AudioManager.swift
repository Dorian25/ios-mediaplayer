//
//  File.swift
//  Mediaplayer
//
//  Created by dorian on 03/08/2022.
//

import Foundation
import AVKit
import SwiftUI

class AudioManager: ObservableObject {
    @EnvironmentObject var settings: AppSettings
    
    @Published var audioPlayer: AVAudioPlayer! // ! : cet objet existera toujours
    @Published var currentSong: Song {
        didSet {
            initAudioPlayer(currentSong)
        }
    }
    
    init(_ song: Song) {
        self.currentSong = song
        initAudioPlayer(song)
    }
    
    
    func initAudioPlayer(_ song: Song) {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: song.fileNamePath)
        } catch {
            print("Fail to initialize")
        }
    }
    
    var currentIndex: Int {
        return settings.songs.firstIndex(of: currentSong) ?? 0
    }
    
    var lastIndex: Int {
        return settings.songs.count - 1
    }
    
    func previousSong() {
        let previousIndex = currentIndex == 0 ? lastIndex : currentIndex - 1
        self.currentSong = settings.songs[previousIndex]
        playSong()
    }
    
    func nextSong() {
        let nextIndex = currentIndex == lastIndex ? 0 : currentIndex + 1
        self.currentSong = settings.songs[nextIndex]
        playSong()
    }
    
    func playSong() {
        initAudioPlayer(currentSong)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        objectWillChange.send()
    }
    
    func pauseSong() {
        audioPlayer.pause()
        objectWillChange.send()
    }
    
    func stopSong() {
        audioPlayer.stop()
    }
}
