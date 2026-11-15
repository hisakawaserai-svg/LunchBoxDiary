//
//  Date+App.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/15.
//
import Foundation

extension Date {
    var startOfDay: Date { Calendar.app.startOfDay(for: self) }
}
