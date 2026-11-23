//
//  UIImage+AppTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/23.
//

import UIKit
import Testing
@testable import LunchBoxDiary

struct UIImageAppTests {
    /// テスト用の画像を生成
    func makeDummyUIImage() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 900, height: 1200), format: format)
        let data: Data = renderer.jpegData(withCompressionQuality: 1) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 450, height: 1200))
            UIColor.blue.setFill()
            context.fill(CGRect(x: 450, y: 0, width: 450, height: 1200))
        }
        
        return UIImage(data: data) ?? UIImage()
    }
    
    // 90度回転が機能しているかを画像幅から確認する
    @Test(arguments: [
        (1, 1200, 900),
        (2, 900, 1200),
        (4, 900, 1200)
    ])
    func rotateImgTest(count: Int, width: CGFloat, height: CGFloat) {
        var data = makeDummyUIImage()
        
        for _ in 0..<count {
            data = data.rotate90()
        }
        #expect(data.size.width == width)
        #expect(data.size.height == height)
    }
}
