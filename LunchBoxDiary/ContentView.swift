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
    @Query(sort: \LunchBox.date, order: .reverse) private var lunchBoxes: [LunchBox]
    
    @State private var isShowCreate: Bool = false

    var body: some View {
        VStack {
            // 仮
            List {
                ForEach(lunchBoxes) { lunch in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(lunch.title)
                            Text(lunch.date, format: .dateTime.year().month(.twoDigits).day(.twoDigits))
                        }
                        if let events = lunch.events {
                            HStack {
                                Text("イベント：")
                                ForEach(events) { event in
                                    Text(event.name)
                                }
                            }
                        }
                    }
                }
            }
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        isShowCreate.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .padding()
                            
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $isShowCreate) {
            CreateView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [LunchBox.self, Event.self, Who.self])
}
