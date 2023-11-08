//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by avalan.zhang on 2023/11/8.
//

import Foundation

struct EmojiArtModel {
    
    var background = Background.blank
    var emojis = [Emoji]()
    
    // 只要成员都是hashable, 则Emoji就是hashable的， 便于放入Set容器中
    struct Emoji: Identifiable, Hashable {
        let id: Int
        let text: String
        var x: Int
        var y: Int
        var size: Int
        
        // fileprivate:此文件内，都可以调用这个init方法，比默认的private权限 松一些
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }
    }
    
    // 避免外界直接操作 emojis 数组
    init() {}
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: location.x, y: location.y, size: size))
    }
    
    
    
    
}
