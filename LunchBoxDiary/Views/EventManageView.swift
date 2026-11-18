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
    private var filteredEvents: [Event] {
        if searchName == "" {
            return events
        }
        return events.filter { $0.name.localizedStandardContains(searchName) }
    }
    
    @FocusState private var isFocused: Bool
    @State private var name: String = ""
    @State private var checkMessage: NameCheckResult?
    
    let selection: Binding<Set<UUID>>?
    init(selection: Binding<Set<UUID>>? = nil) { self.selection = selection }
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
            
            List {
                ForEach(filteredEvents) { event in
                    let selected = selection?.wrappedValue.contains(event.id) ?? false
                    Button {
                        if selected {
                            selection?.wrappedValue.remove(event.id)
                        } else {
                            selection?.wrappedValue.insert(event.id)
                        }
                    } label: {
                        HStack {
                            Text(event.name)
                            Spacer()
                            if selection != nil {
                                Image(systemName: selected ? "checkmark.square" : "square")
                                    .foregroundStyle(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .deleteDisabled(selection != nil)
                }
                .onDelete{ offsets in
                    for index in offsets {
                        modelContext.delete(filteredEvents[index])
                    }
                }
            }
            .searchable(text: $searchName)
        }
    }
}

#Preview {
    NavigationStack {
        EventManageView()
            .modelContainer(for: [LunchBox.self, Event.self, Who.self])
    }
}
