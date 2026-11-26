//
//  LunchBox.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/11.
//

import SwiftData
import Foundation

@Model
final class LunchBox {
    @Attribute(.unique) var id: UUID
    
    var title: String?
    @Attribute(.externalStorage) var image: Data
    var thumbnail: Data
    var date: Date
    var memo: String?
    
    var events: [Event]?
    var who: Who?
    var frame: Frame
    
    init(id: UUID = UUID(), title: String?, image: Data, thumbnail: Data, date: Date, memo: String?, events: [Event]?, who: Who?, frame: Frame) {
        self.id = id
        self.title = title
        self.image = image
        self.thumbnail = thumbnail
        self.date = date
        self.memo = memo
        
        self.events = events
        self.who = who
        self.frame = frame
    }
}

@Model
final class Event {
    @Attribute(.unique) var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

@Model
final class Who {
    @Attribute(.unique) var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

nonisolated struct Frame: Codable {
    var theme: FrameTheme
    var color: String
}

nonisolated enum FrameTheme: String, Codable, CaseIterable {
    case def, garland, film, polaroid, cloud, note, star, mascot
}
