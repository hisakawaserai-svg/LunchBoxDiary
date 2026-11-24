//
//  GarlandFrameView.swift
//  LunchBoxDiary
//
//  Created by Claude on 2026/11/23.
//

import SwiftUI

/// 19 ガーランド。写真は上部いっぱい、その上に旗の飾りを重ねる。
/// 数値は、デザインキャンバス(19)から読み取った(カード左上が原点、1pt = 1px)。
struct GarlandFrameView: View {
    @AppStorage("decorationOpacity") private var decorationOpacity: Double = 0.7

    let color: Color
    @Binding var image: UIImage?
    let title: String?
    let date: Date

    // 色は、選んだ1色から作る(キャンバスの light / deep / b / c)
    private var light: Color { color.mix(with: .white, by: 0.35) }
    private var deep: Color { color.mix(with: .black, by: 0.12) }
    private var flagLight: Color { color.mix(with: .white, by: 0.5) }
    private var flagDark: Color { color.mix(with: .black, by: 0.3) }

    /// 旗(左上の x, y と、塗りの色)
    private var flags: [Flag] {
        [
            Flag(x: 20, y: 11, fill: flagDark),
            Flag(x: 69, y: 17, fill: .white),
            Flag(x: 117, y: 20, fill: flagLight),
            Flag(x: 166, y: 21, fill: Color(hex: "#FFF1B8") ?? .yellow),
            Flag(x: 215, y: 19, fill: flagDark),
            Flag(x: 264, y: 14, fill: .white),
            Flag(x: 303, y: 8, fill: flagLight),
        ]
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // 背景(斜めのグラデーション)
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(
                    stops: [
                        .init(color: light, location: 0),
                        .init(color: color, location: 0.55),
                        .init(color: deep, location: 1),
                    ],
                    startPoint: UnitPoint(x: 0.35, y: 0),
                    endPoint: UnitPoint(x: 0.65, y: 1)
                ))

            // 写真(上部いっぱい。上の角だけ丸い)
            if let image {
                PhotoLink(image: $image) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 326, height: 176, alignment: .center)
                        .clipShape(.rect(topLeadingRadius: 24, topTrailingRadius: 24))
                }
            } else {
                Rectangle().fill(Color(hex: "#E3DBD3") ?? .gray)
                    .frame(width: 326, height: 176)
                    .clipShape(.rect(topLeadingRadius: 24, topTrailingRadius: 24))
            }

            // 写真と紙の境目の白い線
            Rectangle()
                .fill(.white)
                .frame(width: 326, height: 3)
                .shadow(color: .black.opacity(0.25), radius: 1, y: 1)
                .offset(y: 174.5)
                .allowsHitTesting(false)

            // 飾り(紐と旗)。ひとつの層として、同じ濃さをかける
            ZStack(alignment: .topLeading) {
                Path { p in
                    p.move(to: CGPoint(x: -6, y: 8))
                    p.addQuadCurve(to: CGPoint(x: 332, y: 8), control: CGPoint(x: 163, y: 38))
                }
                .stroke(Color(hex: "#8A7F76") ?? .gray, lineWidth: 1.6)

                ForEach(flags) { flag in
                    ZStack {
                        FlagShape().stroke(.white, style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                        FlagShape().fill(flag.fill)
                    }
                    .frame(width: 26, height: 30)
                    .offset(x: flag.x, y: flag.y)
                }
            }
            .frame(width: 326, height: 244, alignment: .topLeading)
            .opacity(decorationOpacity)
            .shadow(color: .black.opacity(0.28), radius: 1, y: 2)
            .clipShape(.rect(cornerRadius: 24))
            .allowsHitTesting(false)

            // タイトルと日付(紙の帯。タイトルは左、日付は右)
            HStack(alignment: .firstTextBaseline) {
                Text(title ?? defaultTitle)
                    .font(.custom("HiraMaruProN-W4", size: 19))
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                Spacer(minLength: 8)
                Text(date.displayDate(.dot))
                    .font(.custom("HiraMaruProN-W4", size: 12))
                    .tracking(1)
                    .fixedSize()
            }
            .foregroundStyle(color.textColor)
            .frame(width: 266)
            .offset(x: 30, y: 194)
        }
        .frame(width: 326, height: 244, alignment: .topLeading)
    }
}

private struct Flag: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let fill: Color
}

/// 逆三角形の旗(上の辺が左右いっぱい、下の頂点が真ん中)
private struct FlagShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    @Previewable @State var img: UIImage? = nil
    GarlandFrameView(
        color: Color(hex: "#A8D8C3") ?? .green,
        image: $img,
        title: "ハンバーグ弁当",
        date: Date()
    )
}
