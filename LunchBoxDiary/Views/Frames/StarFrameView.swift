//
//  StarFrameView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/21.
//

import SwiftUI

struct StarFrameView: View {
    let color: Color
    let image: UIImage?
    let title: String
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
        StarPosition(id: 6, x: 200, y: 222, size: 9),
        StarPosition(id: 7, x: 312, y: 150, size: 8),
        StarPosition(id: 8, x: 6, y: 34, size: 8),
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach(starPositions, id: \.id) { position in
                Image(systemName: "star.fill")
                    .offset(x: position.x, y: position.y)
                    .font(.system(size: position.size))
                    .foregroundColor(color.textColor)
            }
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 240, height: 144)
                    .clipShape(.rect(cornerRadius: 14))
                    .frame(width: 326, alignment: .topLeading)
                    .offset(x: 43, y: 16)
            } else {
                Rectangle()
                    .foregroundColor(color.textColor)
                    .frame(width: 240, height: 144)
                    .clipShape(.rect(cornerRadius: 14))
                    .frame(width: 326, alignment: .topLeading)
                    .offset(x: 43, y: 16)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(dateText)
                    .font(.custom("HiraMaruProN-W4", size: 12))
                    .opacity(0.9)
                    .foregroundColor(color.textColor)
                Text(title)
                    .font(.custom("HiraMaruProN-W4", size: 19))
                    .foregroundColor(color.textColor)
                    .lineLimit(2)
                    .frame(width: 240, alignment: .leading)
                    .minimumScaleFactor(0.8)
            }
            .padding(.top, 170)
            .padding(.leading, 43)
        }
        .frame(width: 326, height: 244, alignment: .topLeading)
    }
}

struct StarPosition {
    let id: Int
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
}
