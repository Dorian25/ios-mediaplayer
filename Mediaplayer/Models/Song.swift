//
//  Music.swift
//  Mediaplayer
//
//  Created by dorian on 02/08/2022.
//

import SwiftUI

struct Song: Identifiable, Equatable {
    let id = UUID()
    let fileName: String
    let fileNamePath: URL
}
