//
//  Color+App.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/19.
//

import SwiftUI

extension Color {
    var hexString: String {
        let resolved = self.resolve(in: EnvironmentValues())

        return "#" +
            [resolved.red, resolved.green, resolved.blue].map {
                    let clamped = max(min($0, 1), 0)
                    return String(format: "%02X", Int((clamped * 255).rounded()))
            }.joined()
    }
}
