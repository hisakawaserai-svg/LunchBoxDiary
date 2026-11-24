//
//  Date+AppTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/24.
//

import Foundation
import Testing
@testable import LunchBoxDiary

struct DateTests {
    var testDate: Date {
        var comp = DateComponents()
        comp.year = 2026
        comp.month = 1
        comp.day = 1
        
        if let date = Calendar.app.date(from: comp) {
            return date
        }
        return Date()
    }
    
    // DateStyleで指定したdisplayDateが帰ってきているかどうか
    @Test(arguments: [
        (.dot, "2026.01.01"),
        (.slash, "2026/01/01"),
        (.kanji, "2026年1月1日")
    ] as [(DateStyle, String)])
    func displayDateTests(style: DateStyle, expect: String) {
        let date = testDate.displayDate(style)
        #expect(date == expect)
    }
}
