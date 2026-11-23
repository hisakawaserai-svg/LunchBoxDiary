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
            .onChange(of: selectedImage) {
                Task {
                    do {
                        uiImage = nil
                        guard let data = try await selectedImage?.loadTransferable(type: Data.self) else { return }
                        let resized = try shrinkAndComp(data, px: screenWidthPx(scale: scale, pt: screenWidthPt))
                        uiImage = UIImage(data: resized)
                    } catch let error as ImageResizeError {
                        imageAlert = .resize(error)
                    } catch {
                        imageAlert = .loadFailed
                    }
                }
            }
            .alert("エラー", isPresented: isAlertShow) {
                Button("閉じる", role: .cancel) {}
            } message: {
                Text(imageAlert?.message ?? "")
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

