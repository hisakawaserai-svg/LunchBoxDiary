//
//  FrameView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/21.
//

import SwiftUI

let frameWidth: CGFloat = 326
let frameHeight: CGFloat = 256

struct FrameView: View {
    let theme: FrameTheme
    let color: Color
    @Binding var image: UIImage?
    let title: String?
    let date: Date

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(color)
            // 背景
            switch theme {
                
            case .def: DefFrameView(color: color, image: $image, title: title, date: date)
            case .garland: GarlandFrameView(color: color, image: $image, title: title, date: date)
            case .autumn, .polaroid, .cloud, .note, .star, .mascot:
                DefFrameView(color: color, image: $image, title: title, date: date)
            }
        }
        .frame(width: frameWidth, height: frameHeight, alignment: .topLeading)
    }
}

#Preview {
    @Previewable @State var img: UIImage? = {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 900, height: 1200), format: format)
        let data: Data = renderer.jpegData(withCompressionQuality: 1) { context in
            UIColor.gray.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 450, height: 1200))
            UIColor.black.setFill()
            context.fill(CGRect(x: 450, y: 0, width: 900, height: 1200))
        }
        let uiImage = UIImage(data: data) ?? UIImage()
        
        return uiImage
    }()
    
    NavigationStack {
        FrameView(theme: .garland, color: .pink, image: $img, title: "春の彩り弁当 Lunch 2026 - Fresh Bento Box - Daily", date: Date())
    }
}
