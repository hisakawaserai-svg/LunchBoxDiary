//
//  Validation.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/17.
//

import Foundation

enum ValidationIssue {
    case titleEmpty
    case noImage
    
    static func validate(title: String, mainImage: Data?, thumbImage: Data?) -> [ValidationIssue] {
        var issues: [ValidationIssue] = []
        
        if title.isEmpty {
            issues.append(.titleEmpty)
        }
        if mainImage == nil || thumbImage == nil {
            issues.append(.noImage)
        }
        
        return issues
    }
    
    var message: String {
        switch self {
        case .titleEmpty: return "タイトルを入力してください"
        case .noImage: return "画像を入力してください"
        }
    }
}
