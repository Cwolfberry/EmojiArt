//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by avalan.zhang on 2023/11/8.
//

import SwiftUI

@main
struct EmojiArtApp: App {

    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
