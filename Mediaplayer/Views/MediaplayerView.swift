//
//  MediaplayerView.swift
//  Mediaplayer
//
//  Created by dorian on 02/08/2022.
//

import SwiftUI

struct MediaplayerView: View {
    var song: Song

    @ObservedObject var barManager = BarManager()
    @StateObject var audioManager: AudioManager
    
    init(song: Song) {
        self.song = song
        self._audioManager = StateObject(wrappedValue: AudioManager(song))
    }
    
    let circleColor: Color = Color(red:0.189, green: 0.187, blue:0.256)
    let circleSize: CGFloat = 200

    var body: some View {
        
        ZStack {
            Circle()
                .frame(width: circleSize, height: circleSize)
                .foregroundColor(circleColor)
            
            HStack {
                ForEach(1..<(barManager.bars.count+1)) { i in
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [barManager.topColor,barManager.bottomColor]), startPoint: .top, endPoint: .bottom)
                            .frame(width: barManager.barWidth,
                                   height: barManager.barMaxHeight)
                            .mask(
                                ZStack {
                                    Capsule()
                                        .frame(width: barManager.barWidth,
                                               height: barManager.bars[i-1].height)
                                }
                                    .frame(width: barManager.barMaxHeight,
                                           alignment: .bottom)
                            )
                    }
                }
            }
        }
        
        HStack {
            Button(action: {audioManager.previousSong()},
                   label:{Image(systemName: "backward.end.fill")})
            
            Spacer()
            
            Button(action: {
                if audioManager.audioPlayer.isPlaying {
                    audioManager.pauseSong()
                } else {
                    audioManager.playSong()
                }
            },
                   label:{Image(systemName: audioManager.audioPlayer.isPlaying ? "pause.circle.fill":"play.circle.fill")})
            
            Spacer()
            
            Button(action: {audioManager.nextSong()},
                   label:{Image(systemName: "forward.end.fill")})
            
        }
        
        
        
        
        
        .onAppear {
            barManager.startAnimation()
            self.audioManager.playSong()
        }
    }
    
    
}
