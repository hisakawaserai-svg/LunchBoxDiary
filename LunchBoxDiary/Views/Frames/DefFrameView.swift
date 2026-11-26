//
//  DefFrameView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/21.
//

import SwiftUI

struct DefFrameView: View {
    let color: Color
    @Binding var image: UIImage?
    let title: String?
    let date: Date
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(color)
            PhotoView(image: $image)
            VStack(alignment: .leading, spacing: 3) {
                Text(date.displayDate(.dot))
                    .font(.custom("HiraMaruProN-W4", size: 12))
                    .opacity(0.9)
                    .foregroundColor(color.textColor)
                Text(title ?? defaultTitle)
                    .font(.custom("HiraMaruProN-W4", size: 19))
                    .foregroundColor(color.textColor)
                    .lineLimit(2)
                    .frame(width: 240, alignment: .leading)
                    .minimumScaleFactor(0.8)
            }
            .padding(.top, 186)
            .padding(.leading, 43)
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
        FrameView(theme: .def, color: .pink, image: $img, title: "春の彩り弁当 Lunch 2026 - Fresh Bento Box - Daily", date: Date())
    }
}
