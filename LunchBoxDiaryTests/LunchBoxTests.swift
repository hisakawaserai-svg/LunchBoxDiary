//
//  LunchBoxDiaryTests.swift
//  LunchBoxDiaryTests
//
//  Created by h S. on 2026/11/11.
//

import Testing
import SwiftUI
import SwiftData
@testable import LunchBoxDiary

@MainActor
struct LunchBoxTests {
    let events = (1...3).map { Event(name: "Test_Event_\($0)") }
    
    private func makeLunchBox(events: [Event]? = nil) -> LunchBox {
        LunchBox(title: "test", image: Data(), thumbnail: Data(),
                 date: .now, memo: nil, event: events, who: nil,
                 frame: Frame(theme: .def, color: "#FFFFFF"))
    }
    
    func makeTestContainer() throws -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        return try ModelContainer(for: LunchBox.self, Event.self, Who.self, configurations: configuration)
    }
    
    @Test
    func eventsLunchBox() throws {
        let container = try makeTestContainer()
        let context = container.mainContext
        
        context.insert(makeLunchBox(events: events))
        try context.save()
        
        let fetchDescriptor = FetchDescriptor<LunchBox>()
        let lunche = try context.fetch(fetchDescriptor)
        
        let names = Set(lunche.first?.event?.map(\.name) ?? [])
        #expect(names == ["Test_Event_1", "Test_Event_2", "Test_Event_3"])
    }
    
    @Test
    func insertEvent() throws {
        let container = try makeTestContainer()
        let context = container.mainContext
        
        for e in events {
            context.insert(e)
        }
        try context.save()
        
        let fetchDescriptor = FetchDescriptor<Event>()
        let events = try context.fetch(fetchDescriptor)
        
        #expect(events.count == 3)
    }
}
