//
//  RectangleCornerRadii+App.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/26.
//

import SwiftUI

extension RectangleCornerRadii {
    init(_ radius: CGFloat) {
        self.init(
            topLeading: radius,
            bottomLeading: radius,
            bottomTrailing: radius,
            topTrailing: radius,
        )
    }
}
