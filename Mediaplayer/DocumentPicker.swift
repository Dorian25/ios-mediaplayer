//
//  DocumentPicker.swift
//  Mediaplayer
//
//  Created by dorian on 01/08/2022.
//

import SwiftUI
import CoreServices

struct DocumentPicker: UIViewControllerRepresentable {
    
    @Binding var dirURL: String
    
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(dirURL: $dirURL)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let controller: UIDocumentPickerViewController
        
        controller = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
        
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {}
}

class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    @Binding var dirURL: String
    
    init(dirURL: Binding<String>){
        _dirURL = dirURL
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let url = urls[0]
        do {
            dirURL = try String(contentsOf: url, encoding: .utf8)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
