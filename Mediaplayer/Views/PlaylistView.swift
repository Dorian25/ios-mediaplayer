//
//  ListMusicView.swift
//  Mediaplayer
//
//  Created by dorian on 01/08/2022.
//


import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var settings : AppSettings
    
    var body: some View {
        List(settings.songs, id: \.id){f in
            Text(f.fileName)
        }
    }
}
