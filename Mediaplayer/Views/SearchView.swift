//
//  ViewTest2.swift
//  Mediaplayer
//
//  Created by dorian on 02/08/2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var settings: AppSettings
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Find a song")
                    .font(.title.weight(.bold))
                Text("Start searching for a song that you want to listen.").padding()
                    .multilineTextAlignment(.center)
            }

        }
        .searchable(text: $searchText) {
            
        }
    }
    
    var results: [String] {
        let lcResults = settings.songs.map{$0.fileName.lowercased()}
        return searchText == "" ? lcResults: lcResults.filter{
            $0.contains(searchText.lowercased())
        }
    }
}

struct ViewTest2_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
