//
//  Calendar+AppTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/12.
//

import Testing
import SwiftUI
@testable import LunchBoxDiary

struct CalendarTests {
    // Calendar.appで作ったTokyoの0時が UTC の15時と同じ瞬間か
    @Test
    func compareTokyoUTC() throws {
        // Asia/Tokyoの日付00:00:00を作る
        let calendar = Calendar.app
        
        let dateCom = DateComponents(
            calendar: calendar,
            year: 2027,
            month: 1,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
        )
        
        let date = try #require(calendar.date(from: dateCom))

        // UTCの日付15:00:00を作る
        var calendarUTC = Calendar.app
        calendarUTC.timeZone = TimeZone(identifier: "UTC")!
        
        let dateComUTC = DateComponents(
            calendar: calendarUTC,
            year: 2026,
            month: 12,
            day: 31,
            hour: 15,
            minute: 0,
            second: 0,
        )
        
        let dateUTC = try #require(calendarUTC.date(from: dateComUTC))
        
        #expect(date == dateUTC)
    }
    
    // UTCで作った日付(12/31 15:00:00)を-1秒し、Tokyoのタイムゾーンに直したときに別の日付になっているか
    @Test
    func checkTimeZone() throws {
        let calendar = Calendar.app
        // UTCの日付15:00:00を作る
        var calendarUTC = Calendar.app
        calendarUTC.timeZone = TimeZone(identifier: "UTC")!
        
        let dateComp = DateComponents(
            calendar: calendarUTC,
            year: 2026,
            month: 12,
            day: 31,
            hour: 15,
            minute: 0,
            second: 0,
        )
        
        let today = try #require(calendarUTC.date(from: dateComp))
        let yesterday = try #require(calendarUTC.date(byAdding: .second, value: -1, to: today))
        
        let todayComp = calendar.dateComponents([.year, .month, .day], from: today)
        let ydayComp = calendar.dateComponents([.year, .month, .day], from: yesterday)
        
        #expect(todayComp != ydayComp)
    }
}
