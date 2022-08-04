//
//  ContentView.swift
//  Mediaplayer
//
//  Created by dorian on 01/08/2022.
//

import SwiftUI

// source fileimporter https://www.youtube.com/watch?v=tnOVnwbkAA0

struct ContentView: View {
    @EnvironmentObject var settings: AppSettings
    @State private var showDocumentPicker = false
    
    @State private var showAlertNoDir = false
    @State private var showAlertNoMp3 = false
    
    
    @State var allFiles: [String] = []
    @State var dirPath = ""
    @State var dirName = ""
    
    var body: some View {
        VStack(alignment:.leading){
            Image("homeimage")
                .resizable()
                .scaledToFit()
                .overlay(
                    Color.black
                        .opacity(0.4)
                        .overlay(
                            Text("Listen to your music")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                        )
                )
            
            Text("You can now listen to all mp3 files ")
            
            
            VStack(alignment: .center){
                Button(action: {showDocumentPicker.toggle()},
                       label:{Text("Choose a directory")
                    .padding(10)})
                
                Text("Folder path").bold()
                Text(dirName)
                
            }.frame(maxWidth: .infinity)
            
            VStack(alignment: .trailing){
                Spacer()
                HStack{
                    Text(String(settings.songs.count) + " mp3 found").padding()
                    Spacer()
                    Button(action: {
                        if dirName != "" {
                            do {
                                allFiles = try FileManager.default.contentsOfDirectory(atPath: dirPath)
                                
                                allFiles.forEach {
                                    if $0.hasSuffix(".mp3") {
                                        settings.songs.append(Song(fileName: $0,
                                                             fileNamePath: URL(fileURLWithPath: dirPath + "/\($0)")))
                                    }
                                }
                                if settings.songs.count == 0 {
                                    showAlertNoMp3.toggle()
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            showAlertNoDir.toggle()
                        }
                    }, label: {Text("Next")})
                    .padding()
                    .alert(isPresented: $showAlertNoDir){
                        Alert(title: Text("Please choose a directory !"),
                              message: Text("Please choose a directory "),
                              dismissButton: .default(Text("Got it !")))
                    }
                }
            } // vstack button next
        }.fileImporter(isPresented: $showDocumentPicker, allowedContentTypes: [.folder]){
            (res) in
            do {
                let folderUrl = try res.get()
                self.dirPath = folderUrl.path
                self.dirName = folderUrl.lastPathComponent
            } catch {
                print(error.localizedDescription)
            }
        } // fileImporter
        .environmentObject(settings)
    } // body
} // contentview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
