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
    
    @Test
    func timeZone() throws {
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
}
