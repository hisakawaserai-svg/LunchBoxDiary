//
//  UIImage+App.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/23.
//

import UIKit

extension UIImage {
    // 画像を90度回転して返す関数
    func rotate90() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: self.size.height, height: self.size.width), format: format)
        return renderer.image { ctx in
            let cgContext = ctx.cgContext
            
            cgContext.translateBy(x: self.size.height / 2, y: self.size.width / 2)
            cgContext.rotate(by: .pi / 2)
            
            self.draw(at: CGPoint(
                x: -self.size.width / 2,
                y: -self.size.height / 2
            ))
        }
    }
}
