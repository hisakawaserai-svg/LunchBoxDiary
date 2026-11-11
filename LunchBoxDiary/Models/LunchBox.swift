//
//  LunchBox.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/11.
//

import SwiftData

struct Frame: Codable {
    var theme: FrameTheme
    var color: String
}

enum FrameTheme: String, Codable {
    case def, stripe, autumn, polaroid, cloud, note, star, mascot
}
