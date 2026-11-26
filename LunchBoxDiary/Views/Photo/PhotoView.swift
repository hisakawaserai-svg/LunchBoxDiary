//
//  PhotoView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/26.
//

import SwiftUI

struct PhotoView: View {
    @Binding var image: UIImage?
    var width: CGFloat = frameWidth
    var height: CGFloat = 176
    var radius: RectangleCornerRadii = .init(topLeading: 24, topTrailing: 24)
    
    var body: some View {
        if let image {
            PhotoLink(image: $image) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height, alignment: .center)
                    .clipShape(.rect(cornerRadii: radius))
            }
        } else {
            Rectangle().fill(Color(hex: "#E3DBD3") ?? .gray)
                .frame(width: width, height: height, alignment: .topLeading)
                .clipShape(.rect(cornerRadii: radius))
        }
    }
}
