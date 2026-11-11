//
//  ContentView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/11.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {

    }
}

#Preview {
    ContentView()
        .modelContainer(for: [LunchBox.self, Event.self, Who.self])
}
