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
    
    @State private var isShowCreate: Bool = false

    var body: some View {
        VStack {
            // 仮
            ScrollView {}
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
