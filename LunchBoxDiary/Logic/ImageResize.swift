//
//  ImageResize.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/13.
//

import UIKit

/// 引数dataを縮小 -> 圧縮 -> Dataに変換
func shrinkAndComp(_ data: Data, px: CGFloat = CGFloat(200)) throws -> Data {
    guard px > 0 else { throw ImageResizeError.shrinkSize }
    guard let uiImg = UIImage(data: data) else { throw ImageResizeError.notImage }
    
    let img: UIImage
    if max(uiImg.size.width, uiImg.size.height) > px {
        guard let shrinkImg = uiImg.preparingThumbnail(of: CGSize(width: px, height: px)) else { throw ImageResizeError.cantShrink }
        img = shrinkImg
    } else {
        img = uiImg
    }
    guard let compreImg = img.jpegData(compressionQuality: 0.5) else { throw ImageResizeError.cantCompre }

    return compreImg
}
/// 画面サイズpx
func screenWidthPx(scale: CGFloat, pt: CGFloat) -> CGFloat {
    return scale * pt
}

enum ImageResizeError: Error {
    case shrinkSize // 縮小サイズが0以下
    case notImage
    case cantShrink // 縮小できなかった
    case cantCompre // 圧縮できなかった
}
