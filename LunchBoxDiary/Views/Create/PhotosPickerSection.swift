//
//  PhotosPickerSection.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/16.
//

import SwiftUI
import PhotosUI

struct PhotosPickerSection: View {
    @State private var selectedImage: PhotosPickerItem?
    @Binding var mainImage: Data?
    @Binding var thumbImage: Data?
    @Binding var uiImage: UIImage?
    
    @Environment(\.displayScale) private var scale  // 1ポイントあたりのpx数
    let screenWidthPt: CGFloat
    
    @State private var imageAlert: ImageError?
    private var isAlertShow: Binding<Bool> {
        Binding(
            get: { imageAlert != nil },
            set: { if !$0 { imageAlert = nil } }
        )
    }
    
    var body: some View {
        PhotosPicker("写真を選んでください", selection: $selectedImage, matching: .images)
            .task(id: selectedImage) {
                do {
                    mainImage = nil
                    uiImage = nil
                    thumbImage = nil

                    guard let data = try await selectedImage?.loadTransferable(type: Data.self) else { return }
                    let resized = try shrinkAndComp(data, px: screenWidthPx(scale: scale, pt: screenWidthPt))
                    mainImage = resized
                    uiImage = UIImage(data: resized)
                    thumbImage = try shrinkAndComp(data)
                } catch let error as ImageResizeError {
                    imageAlert = .resize(error)
                } catch {
                    imageAlert = .loadFailed
                }
            }
            .alert("エラー", isPresented: isAlertShow) {
                Button("閉じる", role: .cancel) {}
            } message: {
                Text(imageAlert?.message ?? "")
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
    }
}

enum ImageError: Error {
    case resize(ImageResizeError)
    case loadFailed
    
    var message: String {
        switch self {
        case .resize(.notImage), .loadFailed:
            return "写真を読み込めませんでした"
        case .resize(.shrinkSize), .resize(.cantShrink), .resize(.cantCompre):
            return "うまく処理できませんでした"
        }
    }
}

