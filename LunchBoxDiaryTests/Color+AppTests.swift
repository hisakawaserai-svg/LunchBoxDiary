//
//  Color+AppTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/19.
//

import SwiftUI
import Testing
@testable import LunchBoxDiary

struct ColorTests {
    // Color.hexStringを通した後の16進数があっているか
    @Test(arguments: [
        (Color.black, "#000000"),
        (Color.white, "#FFFFFF"),
        (Color(red: 10/255, green: 161/255, blue: 15/255), "#0AA10F")
    ])
    func colorToStr(color: Color, expect: String) {
        let result = color.hexString
        #expect(result == expect)
    }
}
