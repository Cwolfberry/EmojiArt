//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by avalan.zhang on 2023/11/8.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
           documentBody
           palette
        }
    }
    
    var documentBody: some View {
        
        GeometryReader { geometry in
            ZStack {
                Color.yellow
                ForEach(document.emojis) { emoji in
                    Text(emoji.text)
                        .font(.system(size: fontSize(for: emoji)))
                        .position(position(for: emoji, in: geometry))
                }
            }
            .onDrop(of: [.plainText], isTargeted: nil) { providers, location in
                return drop(providers: providers, at: location, in: geometry)
                
            }
        }
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        return providers.loadFirstObject(ofType: String.self) { string in
            if let emoji = string.first, emoji.isEmoji {
                document.addEmoji(String(emoji), at: converToEmojiCoordinates(location, in: geometry), size: defaultEmojiFontSize)
            }
        }
    }
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }
    
    private func converToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        // .center: CGRect extension
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: location.x - center.x,
            y: location.y - center.y
        )
        return  (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        // .center: CGRect extension
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x),
            y: center.y + CGFloat(location.y)
        )
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    var palette: some View {
        // .font:  go through inner views -> Text
        ScrollingEmojisView(emojis: testEmojis)
            .font(.system(size: defaultEmojiFontSize))
    }
    
    let testEmojis = "😀😇😂😈👹🎃🫑🌽⚽️🪂🏋️🚘🧭💡💰❤️🔱🇧🇪🇨🇦🪜🧨🧺🔮📙🥇🏆🚴‍♂️🎲🎯🪗🎹🎻🎧🎬🎰s"
}


struct ScrollingEmojisView : View {
    let emojis: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0)} , id:\.self) { emoji in
                    Text(emoji)
                        .onDrag({ NSItemProvider(object: emoji as NSString) })
                }
            }
        }
    }
}



#Preview {
    EmojiArtDocumentView(document: EmojiArtDocument())
}
