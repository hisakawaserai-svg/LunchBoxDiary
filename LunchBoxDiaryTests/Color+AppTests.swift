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
    
    // Color(hex: )の戻り値がColor型の期待と一致しているかどうか
    @Test(arguments: [
        ("#FFFFFF", Color.white),
        ("#FFF", nil),
        ("f2a7b9", Color(red: 242 / 255, green: 167 / 255, blue: 185 / 255))
    ])
    func strToColor(str: String, expect: Color?) {
        let color = Color(hex: str)
        #expect(color == expect)
    }
    
    // Color.hexString -> Color(hex: ) -> Color.hexString した値が初めと一致しているかどうか
    @Test(arguments: ["#FFFFFF", "#0AA10F", "#F2A7B9"])
    func returnClr(str: String) {
        let color = Color(hex: str)
        let string = color?.hexString
        
        #expect(str == string)
    }
    
    // textColorに引数として入れた背景色が相対輝度として見えやすい方の色に変換されるか(背景: 白, テキストカラー: 暗い色)
    @Test(arguments: [
        (Color.white, "#3A2E2E"),
        (Color.black, "#FFFFFF"),
        (Color(hex: "#F2A7B9"), "#3A2E2E")
    ])
    func textColor(color: Color?, expect: String) {
        #expect(color?.textColor.hexString == expect)
        #expect(color?.textColor == Color(hex: expect))
    }
    
    // Color.mixを通した値が期待通りか
    @Test(arguments: [
        ("#F6C177", Color.white, 0.78, "#FDF1E1"),
        ("#4A6FA5", Color.white, 0.78, "#D7DFEB"),
        ("#F6C177", Color.black, 0.45, "#876A41"),
        ("#FFFFFF", Color.black, 1, "#000000"),
        ("#FFFFFF", Color.black, 0, "#FFFFFF")
    ])
    func mixColor(origin: String, other: Color, ratio: Double, expect: String) {
        let oriColor = Color(hex: origin)
        let resultColor = oriColor?.mix(with: other, by: ratio)
        
        #expect(resultColor?.hexString == expect)
    }
}
