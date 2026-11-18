//
//  EventManageView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/18.
//

import SwiftUI
import SwiftData

struct EventManageView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Event.name) private var events: [Event]
    @FocusState private var isFocused: Bool
    @State private var name: String = ""
    @State private var checkMessage: NameCheckResult?
    
    @State private var searchName: String = ""
    
    var body: some View {
        VStack {
            Text("登録したいイベント名を入力してください")
            HStack {
                VStack(alignment: .leading) {
                    TextField("名前", text: $name)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused)
                    Text(checkMessage?.message ?? "")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading)
                }
                Button {
                    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let check = NameCheckResult.checkName(trimmed, existing: events.map(\.name))
                
                    if check == .ok {
                        modelContext.insert(Event(name: trimmed))
                        isFocused = false
                        name = ""
                        checkMessage = nil
                    } else {
                        checkMessage = (check)
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .padding()
                }
            }
            Divider()
            
            TextField("検索", text: $searchName)
                .padding()
                .textFieldStyle(.roundedBorder)
            List {
                ForEach(events) { event in
                    Text(event.name)
                }
            }
        }
    }
}

#Preview {
    EventManageView()
        .modelContainer(for: [LunchBox.self, Event.self, Who.self])
}
