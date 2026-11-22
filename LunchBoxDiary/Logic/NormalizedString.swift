//
//  NormalizedString.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/22.
//

import Foundation

/// 引数strをトリムして空ならnilを返す
func normalizedString(_ str: String) -> String? {
    let trimmedStr: String = str.trimmingCharacters(in: .whitespacesAndNewlines)
    let recordStr: String? = !trimmedStr.isEmpty ? trimmedStr : nil
    
    return recordStr
}
