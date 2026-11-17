//
//  CreateView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/11.
//

import SwiftUI
import SwiftData

struct CreateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var screenWidthPt: CGFloat = 0   // 写真の縮小に使う、画面の幅(pt)
    
    @State private var title: String = ""
    @State private var mainImage: Data?
    @State private var thumbImage: Data?
    @State private var date: Date = Date()
    @State private var memo: String = ""
    @State private var events: [Event]?
    @State private var who: Who?
    @State private var frameTheme: FrameTheme = .def
    @State private var frameColor: Color = .pink
    
    @State private var issues: [ValidationIssue] = []
    @ViewBuilder private func textIssue(_ validation: ValidationIssue) -> some View {
        if issues.contains(validation) {
            Text(validation.message)
                .font(.caption)
                .foregroundColor(.red)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("")) {
                    VStack(alignment: .leading) {
                        TextField("タイトル", text: $title)
                        textIssue(.titleEmpty)
                    }
                    VStack(alignment: .leading) {
                        PhotosPickerSection(mainImage: $mainImage, thumbImage: $thumbImage, screenWidthPt: screenWidthPt)
                        textIssue(.noImage)
                    }
                    DatePicker(
                        "日付",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    TextField("メモ", text: $memo, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(3...6)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: { Image(systemName: "xmark") }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("保存") {
                        let trimmedTitle: String = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        // メモ
                        let trimmedMemo: String = memo.trimmingCharacters(in: .whitespacesAndNewlines)
                        let recordMemo: String? = !trimmedMemo.isEmpty ? trimmedMemo : nil

                        issues = ValidationIssue.validate(title: trimmedTitle, mainImage: mainImage, thumbImage: thumbImage)
                    
                        if issues.isEmpty, let mainImage, let thumbImage {
                            modelContext.insert(LunchBox(title: trimmedTitle, image: mainImage, thumbnail: thumbImage, date: date.startOfDay, memo: recordMemo, events: nil, who: nil, frame: Frame(theme: .def, color: "#000000")))
                            dismiss()
                        }
                    }
                }
            }
        }
        .onGeometryChange(for: CGFloat.self, of: { $0.size.width }) { newWidthPt in
            screenWidthPt = newWidthPt
        }
    }
}

#Preview {
    CreateView()
}
