//
//  LunchBox.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/11.
//

import SwiftData
import Foundation

@Model
final class Event {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

@Model
final class Who {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

struct Frame: Codable {
    var theme: FrameTheme
    var color: String
}

enum FrameTheme: String, Codable {
    case def, stripe, autumn, polaroid, cloud, note, star, mascot
}
