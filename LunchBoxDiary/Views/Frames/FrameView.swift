//
//  FrameView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/21.
//

import SwiftUI

struct FrameView: View {
    let theme: FrameTheme
    let color: Color
    let image: UIImage?
    let title: String
    let date: Date

    private var colorA: Color { color.mix(with: .white, by: 0.78) }
    private var colorB: Color { color.mix(with: .white, by: 0.5) }
    private var colorC: Color { color.mix(with: .black, by: 0.45) }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(color)
            // 背景
            switch theme {
                
            case .def:
                StarFrameView(color: color, image: image, title: title, date: date)
            case .stripe, .autumn, .polaroid, .cloud, .note, .star, .mascot:
                StarFrameView(color: color, image: image, title: title, date: date)
            }
        }
        .frame(width: 326, height: 244)
    }
}

#Preview {
    /// テスト用の画像を生成
    var dummyData: UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1200, height: 1200), format: format)
        let data: Data = renderer.jpegData(withCompressionQuality: 1) { context in
            UIColor.white.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1200, height: 1200))
        }
        let uiImage = UIImage(data: data)
        
        return uiImage
    }
    
    FrameView(theme: .def, color: .pink, image: dummyData, title: "春の彩り弁当 Lunch 2026 - Fresh Bento Box - Daily", date: Date())
}
