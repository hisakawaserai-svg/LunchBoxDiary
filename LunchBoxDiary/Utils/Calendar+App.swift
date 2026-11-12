//
//  Calendar+App.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/12.
//

import SwiftUI

extension Calendar {
    static let app: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        return calendar
    }()
}
