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
    
    // CreateView
    @State private var screenWidthPt: CGFloat = 0
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
        .onGeometryChange(for: CGFloat.self, of: { $0.size.width }) { newWidthPt in
            screenWidthPt = newWidthPt
        }
        .fullScreenCover(isPresented: $isShowCreate) {
            CreateView(screenWidthPt: screenWidthPt)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [LunchBox.self, Event.self, Who.self])
}
