//
//  StarFrameView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/21.
//

import SwiftUI

struct StarFrameView: View {
    @AppStorage("decorationOpacity") private var decorationOpacity: Double = 0.7
    
    let color: Color
    let image: UIImage?
    let title: String?
    let date: Date
    private var dateText: String {
        let c = Calendar.app.dateComponents([.year, .month, .day], from: date)
        return String(format: "%d.%02d.%02d", c.year ?? 0, c.month ?? 0, c.day ?? 0)
    }
    
    let starPositions: [StarPosition] = [
        StarPosition(id: 0, x: 22, y: 6, size: 12),
        StarPosition(id: 1, x: 268, y: 4, size: 9),
        StarPosition(id: 2, x: 302, y: 70, size: 14),
        StarPosition(id: 3, x: 8, y: 100, size: 10),
        StarPosition(id: 4, x: 290, y: 212, size: 18),
        StarPosition(id: 5, x: 22, y: 150, size: 9),
        StarPosition(id: 6, x: 20, y: 232, size: 9),
        StarPosition(id: 7, x: 312, y: 150, size: 8),
        StarPosition(id: 8, x: 6, y: 34, size: 8),
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 326, height: 176, alignment: .topLeading)
                    .clipShape(.rect(topLeadingRadius: 24, topTrailingRadius: 24))
            } else {
                Rectangle().fill(Color(hex: "#E3DBD3") ?? .gray)
                    .frame(width: 326, height: 176, alignment: .topLeading)
                    .clipShape(.rect(topLeadingRadius: 24, topTrailingRadius: 24))
            }
            ForEach(starPositions, id: \.id) { position in
                Image(systemName: "star.fill")
                    .offset(x: position.x, y: position.y)
                    .font(.system(size: position.size))
                    .foregroundColor(color.textColor)
                    .opacity(decorationOpacity)
                    .shadow(color: .black.opacity(0.35), radius: 1, y: 1)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(dateText)
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
        .frame(width: 326, height: 256, alignment: .topLeading)
    }
}

struct StarPosition {
    let id: Int
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
}

#Preview {
    FrameView(theme: .def, color: .pink, image: nil, title: "春の彩り弁当 Lunch 2026 - Fresh Bento Box - Daily", date: Date())
}
