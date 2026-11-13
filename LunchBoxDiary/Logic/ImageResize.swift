//
//  ImageResize.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/13.
//

import UIKit
/// 引数dataを縮小 -> 圧縮 -> Dataに変換
func shrinkAndComp(_ data: Data, px: CGFloat = CGFloat(200)) -> Data? {
    guard let uiImg = UIImage(data: data) else { return nil }
    guard let shrinkImg = uiImg.preparingThumbnail(of: CGSize(width: px, height: px)) else { return uiImg.jpegData(compressionQuality: 0.5) }

    return shrinkImg.jpegData(compressionQuality: 0.5)
}
/// 画面サイズpx
func screenWidthPx(scale: CGFloat, pt: CGFloat) -> CGFloat {
    return scale * pt
}
