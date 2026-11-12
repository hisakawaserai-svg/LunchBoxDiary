//
//  LunchBoxDiaryApp.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/11.
//

import SwiftUI
import SwiftData

@main
struct LunchBoxDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [LunchBox.self, Event.self, Who.self])
        .environment(\.calendar, Calendar.app)
        .environment(\.timeZone, Calendar.app.timeZone)
    }
}
