//
//  ContentView2.swift
//  Mediaplayer
//
//  Created by dorian on 02/08/2022.
//

import SwiftUI

struct ContentView2: View {
    @StateObject var settings = AppSettings()
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem() {
                    Image(systemName: "folder.fill.badge.questionmark")
                    Text("Dossier")
                }
            PlaylistView()
                .tabItem() {
                    Image(systemName: "music.note.list")
                    Text("Playlist")
                }
            SearchView()
                .tabItem() {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .environmentObject(settings)
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
