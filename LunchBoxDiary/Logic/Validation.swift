//
//  Validation.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/17.
//

import Foundation

enum ValidationIssue {
    case titleEmpty
    case charLimit
    case noImage
    
    static func validate(title: String, mainImage: Data?, thumbImage: Data?) -> [ValidationIssue] {
        var issues: [ValidationIssue] = []
        
        if title.isEmpty {
            issues.append(.titleEmpty)
        }
        if validChar(title) > titleMaxLength {
            issues.append(.charLimit)
        }
        if mainImage == nil || thumbImage == nil {
            issues.append(.noImage)
        }
        
        return issues
    }
    
    var message: String {
        switch self {
        case .titleEmpty: return "タイトルを入力してください"
        case .charLimit: return "タイトルが長すぎます"
        case .noImage: return "画像を入力してください"
        }
    }
}

/// 引数 title の文字数を重み付で返す（重み付| 1: A、1、スペース、記号 | 2: あ、漢字、全角英数）
func validChar(_ title: String) -> Int {
    let count = title.reduce(0) { result, char in
        result + (char.isASCII ? 1 : 2)
    }
    return count
}

let titleMaxLength: Int = 48
