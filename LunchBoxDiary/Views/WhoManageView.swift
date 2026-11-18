//
//  WhoManageView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/18.
//

import SwiftUI
import SwiftData

struct WhoManageView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Who.name) private var whos: [Who]
    private var filteredWho: [Who] {
        if searchName == "" {
            return whos
        }
        return whos.filter { $0.name.localizedStandardContains(searchName) }
    }
    
    @FocusState private var isFocused: Bool
    @State private var name: String = ""
    @State private var checkMessage: NameCheckResult?
    
    let selection: Binding<UUID?>?
    init(selection: Binding<UUID?>? = nil) { self.selection = selection }
    @State private var searchName: String = ""
    
    var body: some View {
        VStack {
            Text("登録したい人を入力してください")
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
                    let check = NameCheckResult.checkName(trimmed, existing: whos.map(\.name))
                
                    if check == .ok {
                        modelContext.insert(Who(name: trimmed))
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
                ForEach(filteredWho) { who in
                    Button {
                        if selection?.wrappedValue == who.id {
                            selection?.wrappedValue = nil
                        } else {
                            selection?.wrappedValue = who.id
                        }
                    } label: {
                        HStack {
                            Text(who.name)
                            Spacer()
                            if selection?.wrappedValue == who.id {
                                Image(systemName: "checkmark.circle.fill")
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
                        modelContext.delete(filteredWho[index])
                    }
                }
            }
            .searchable(text: $searchName)
        }
    }
}

#Preview {
    NavigationStack {
        WhoManageView()
            .modelContainer(for: [LunchBox.self, Event.self, Who.self])
    }
}
