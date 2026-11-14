//
//  ImageResizeTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/14.
//

import UIKit
import Foundation
import Testing
@testable import LunchBoxDiary

struct ImageResizeTests {
    /// テスト用の画像を生成
    func makeDummyData(widthPx: CGFloat = 200, heightPx: CGFloat = 200) -> Data {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: widthPx, height: heightPx), format: format)
        let data: Data = renderer.jpegData(withCompressionQuality: 1) { context in
            UIColor.blue.setFill()
            context.fill(CGRect(x: 0, y: 0, width: widthPx, height: heightPx))
        }
        
        return data
    }
    
    /// shrinkAndCompの引数 px に 0 が渡された場合に吐く Error が ImageResizeError(.shrinkSize) かどうか
    /// shrinkAndCompの引数 px に 負の数(-1) が渡された場合に吐く Error が ImageResizeError(.shrinkSize) かどうか
    @Test(arguments: [0, -1])
    func invalidPx(px: CGFloat) throws {
        let data = makeDummyData()
    
        let error = #expect(throws: ImageResizeError.self) {
            try shrinkAndComp(data, px: px)
        }
        #expect(error == .shrinkSize)
    }
    
    /// UIImageに変換できないData型が渡された場合に吐く Error が ImageResizeError(.notImage) かどうか
    @Test
    func notImage() throws {
        let text: String = "This is a test!!"
        let data: Data = Data(text.utf8)
        
        let error = #expect(throws: ImageResizeError.self) {
            try shrinkAndComp(data)
        }
        #expect(error == .notImage)
    }
    
    /// shrinkAndCompで指定したサイズに縮小できているかどうか
    @Test
    func shrinkToPx() throws {
        let data = makeDummyData(widthPx: 1200, heightPx: 1200)

        let imgData = try shrinkAndComp(data, px: 100)
        let img = try #require(UIImage(data: imgData))

        #expect(img.size == CGSize(width: 100, height: 100))
    }
    
    /// 縮小後にアスペクト比が同じかどうか
    @Test(arguments: [(1200, 900), (1600, 900), (600, 900)])
    func calcRatio(wPx: CGFloat, hPx: CGFloat) throws {
        let data = makeDummyData(widthPx: wPx, heightPx: hPx)
        let ansRatio = wPx / hPx
        
        let imageData = try shrinkAndComp(data, px: 100)
        let img = try #require(UIImage(data: imageData))
        let imgRatio = img.size.width / img.size.height
        
        #expect(abs(ansRatio - imgRatio) < 0.05)
        #expect(max(img.size.width, img.size.height) == 100)
    }
    
    /// 元画像の方がサイズが小さい場合、元サイズのまま帰ってくるか
    @Test
    func littlePx() throws {
        let data = makeDummyData(widthPx: 50, heightPx: 50)

        let imgData = try shrinkAndComp(data, px: 100)
        let img = try #require(UIImage(data: imgData))

        #expect(img.size == CGSize(width: 50, height: 50))
    }
}
