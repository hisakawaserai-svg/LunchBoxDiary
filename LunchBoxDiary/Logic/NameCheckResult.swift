//
//  NameCheckResult.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/18.
//

import Foundation

nonisolated enum NameCheckResult {
    case empty, duplicate, ok
    
    /// 空・重複を、判定して、結果を返す
    static func checkName(_ trimmed: String, existing: [String]) -> NameCheckResult {
        if trimmed.isEmpty { return .empty }
        if existing.contains(trimmed) { return .duplicate }
        
        return .ok
    }
    
    var message: String? {
        switch self {
        case .empty: return "イベント名を入力してください"
        case .duplicate: return "すでに存在するイベント名です"
        case .ok: return nil
        }
    }
}
