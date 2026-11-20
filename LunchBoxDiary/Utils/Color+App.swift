//
//  Color+App.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/19.
//

import SwiftUI

extension Color {
    // 16進数の#RRGGBBをColor型に変換する
    init?(hex: String) {
        let cleaned = hex.replacingOccurrences(of: "#", with: "")
        guard cleaned.count == 6, cleaned.allSatisfy(\.isHexDigit), let rgbValue = Int(cleaned, radix: 16) else { return nil }
        
        let red = Double(rgbValue >> 16) / 255
        let green = Double((rgbValue >> 8) & 0xFF) / 255
        let blue = Double(rgbValue & 0xFF) / 255
        self.init(red: red, green: green, blue: blue)
    }
    
    // Color型を16進数の文字列に変換する
    var hexString: String {
        let resolved = self.resolve(in: EnvironmentValues())

        return "#" +
            [resolved.red, resolved.green, resolved.blue].map {
                    let clamped = max(min($0, 1), 0)
                    return String(format: "%02X", Int((clamped * 255).rounded()))
            }.joined()
    }
    
    // 相対輝度を使い、テキストカラーを背景色と被らず、見やすい色(白 or 黒)にする
    var textColor: Color {
        let resolved = self.resolve(in: EnvironmentValues())
        let array = [resolved.red, resolved.green, resolved.blue]
        
        let c_linear = array.map { c in
            c <= 0.03928 ? c / 12.92 : pow(((c + 0.055) / 1.055), 2.4)
        }
        
        let L = 0.2126 * c_linear[0] + 0.7152 * c_linear[1] + 0.0722 * c_linear[2]
        
        if L > 0.35 {
            return Color(hex: "#3A2E2E") ?? .black
        } else {
            return Color(hex: "#FFFFFF") ?? .white
        }
    }
}
