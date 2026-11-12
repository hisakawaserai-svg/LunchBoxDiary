//
//  CreateView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/11.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) private var scale  // 1ポイントあたりのpx数
    @Environment(\.modelContext) private var modelContext
    
    let screenWidth: CGFloat
    @State private var selectedImage: PhotosPickerItem?
    
    @State private var title: String = ""
    @State private var mainImage: Data?
    @State private var thumbImage: Data?
    @State private var date: Date = Date()
    @State private var memo: String?
    @State private var event: [Event]?
    @State private var who: Who?
    @State private var frameTheme: FrameTheme = .def
    @State private var frameColor: Color = .pink
    
    /// 引数dataを縮小 -> 圧縮 -> Dataに変換
    func shrinkAndComp(_ data: Data, detailPx: CGFloat = CGFloat(200)) -> Data? {
        guard let uiImg = UIImage(data: data) else { return nil }
        guard let shrinkImg = uiImg.preparingThumbnail(of: CGSize(width: detailPx, height: detailPx)) else { return uiImg.jpegData(compressionQuality: 0.5) }

        return shrinkImg.jpegData(compressionQuality: 0.5)
    }
    /// 画面サイズpx
    func detailPx() -> CGFloat {
        return scale * screenWidth
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("")) {
                    TextField("タイトル", text: $title)
                    PhotosPicker("写真を選んでください", selection: $selectedImage, matching: .images)
                        .task(id: selectedImage) {
                            guard let data = try? await selectedImage?.loadTransferable(type: Data.self) else { return }
                            if let mainImg = shrinkAndComp(data, detailPx: detailPx()){
                                mainImage = mainImg
                            }
                            if let thumbImg = shrinkAndComp(data){
                                thumbImage = thumbImg
                            }
                        }
                    if let mainImage, let mainImg = UIImage(data: mainImage) {
                        Image(uiImage: mainImg)
                            .resizable()
                            .scaledToFit()
                    }
                    if let thumbImage, let thumbImg = UIImage(data: thumbImage) {
                        Image(uiImage: thumbImg)
                            .resizable()
                            .scaledToFit()
                    }
                    DatePicker(
                        "日付を選んでください",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: { Image(systemName: "xmark") }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("保存") {
                        if let mainImage, let thumbImage {
                            modelContext.insert(LunchBox(title: title, image: mainImage, thumbnail: thumbImage, date: date, memo: memo, events: nil, who: nil, frame: Frame(theme: .def, color: "#000000")))
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CreateView(screenWidth: 1200)
}
