//
//  Date+App.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/15.
//
import Foundation

extension Date {
    var startOfDay: Date { Calendar.app.startOfDay(for: self) }
    
    /// dateからstyleのformatに直したStringを返す
    func displayDate(_ style: DateStyle) -> String {
        let comp = Calendar.app.dateComponents([.year, .month, .day], from: self)
        let year = comp.year ?? 0
        let month = comp.month ?? 0
        let day = comp.day ?? 0
        
        switch style {
        case .dot: return String(format: "%d.%02d.%02d", year, month, day)
        case .slash: return String(format: "%d/%02d/%02d", year, month, day)
        case .kanji: return String(format: "%d年%d月%d日", year, month, day)
        }
    }
}

enum DateStyle { case dot, slash, kanji }
