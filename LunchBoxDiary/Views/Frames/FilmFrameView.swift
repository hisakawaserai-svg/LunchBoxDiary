//
//  FilmFrameView.swift
//  LunchBoxDiary
//
//  Created by Claude on 2026/11/26.
//

import SwiftUI

/// 25 フィルム。左右に穴のあいた黒い帯、写真は内側の小さい窓。
/// 数値は、デザインキャンバス(25)をもとに、高さ256に合わせて調整した(カード左上が原点)。
struct FilmFrameView: View {
    @AppStorage("decorationOpacity") private var decorationOpacity: Double = 0.7

    let color: Color
    @Binding var image: UIImage?
    let title: String?
    let date: Date

    // 色は、選んだ1色から作る(キャンバスの light / deep)
    private var light: Color { color.mix(with: .white, by: 0.4) }
    private var deep: Color { color.mix(with: .black, by: 0.14) }
    /// フィルムの帯と、写真の黒枠の色
    private var ink: Color { Color(hex: "#3A2E2E") ?? .black }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // 背景(ほぼ縦のグラデーション)
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(
                    stops: [
                        .init(color: light, location: 0),
                        .init(color: color, location: 0.6),
                        .init(color: deep, location: 1),
                    ],
                    startPoint: UnitPoint(x: 0.4, y: 0),
                    endPoint: UnitPoint(x: 0.6, y: 1)
                ))

            // 飾り(左右の帯と、上下の目印の線)。ひとつの層にまとめて、同じ濃さをかける
            ZStack(alignment: .topLeading) {
                filmStrip
                filmStrip.offset(x: 302)

                Rectangle().fill(ink.opacity(0.5))
                    .frame(width: 1, height: 16)
                    .offset(x: 162.5)
                Rectangle().fill(ink.opacity(0.5))
                    .frame(width: 1, height: 16)
                    .offset(x: 162.5, y: 240)
            }
            .frame(width: frameWidth, height: frameHeight, alignment: .topLeading)
            .compositingGroup()
            .opacity(decorationOpacity)
            .clipShape(.rect(cornerRadius: 24))
            .allowsHitTesting(false)

            // 写真(黒枠の太さ3の分だけ、左上にずらして置く)
            photo
                .padding(3)
                .background(ink, in: .rect(cornerRadius: 3))
                .shadow(color: ink.opacity(0.25), radius: 6, y: 6)
                .offset(x: 40, y: 21)

            // タイトルと日付(中央そろえ)
            VStack(spacing: 3) {
                Text(title ?? defaultTitle)
                    .font(.custom("HiraMinProN-W3", size: 18))
                    .tracking(1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(date.displayDate(.dot))
                    .font(.custom("SnellRoundhand", size: 15))
            }
            .foregroundStyle(color.textColor)
            .frame(width: 240)
            .offset(x: 43, y: 184)
        }
        .frame(width: frameWidth, height: frameHeight, alignment: .topLeading)
    }

    /// フィルムの帯1本(幅24)。穴は、同じ角丸の四角を縦に並べる
    private var filmStrip: some View {
        VStack(spacing: 9) {
            ForEach(0..<11, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 2.5)
                    .fill(light)
                    .frame(width: 10, height: 13)
            }
        }
        .frame(width: 24, height: frameHeight)
        .background(ink)
    }

    @ViewBuilder private var photo: some View {
        if let image {
            PhotoLink(image: $image) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 240, height: 144, alignment: .center)
                    .clipShape(.rect(cornerRadius: 2))
            }
        } else {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(hex: "#E3DBD3") ?? .gray)
                .frame(width: 240, height: 144)
        }
    }
}

#Preview {
    @Previewable @State var img: UIImage? = nil
    NavigationStack {
        FilmFrameView(
            color: Color(hex: "#E4CFA2") ?? .yellow,
            image: $img,
            title: "ハンバーグ弁当",
            date: Date()
        )
    }
}
