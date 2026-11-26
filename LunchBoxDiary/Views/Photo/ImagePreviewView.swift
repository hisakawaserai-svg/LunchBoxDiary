//
//  ImagePreviewView.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/23.
//

import SwiftUI

struct ImagePreviewView: View {
    @Binding var image: UIImage?
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .background(Color.black.opacity(0.7).ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    image = image?.rotate90()
                } label: {
                    Image(systemName: "rotate.right")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var img: UIImage? = {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 900, height: 1200), format: format)
        let data: Data = renderer.jpegData(withCompressionQuality: 1) { context in
            UIColor.gray.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 450, height: 1200))
            UIColor.black.setFill()
            context.fill(CGRect(x: 450, y: 0, width: 450, height: 1200))
        }
        let uiImage = UIImage(data: data) ?? UIImage()
        
        return uiImage
    }()
    
    ImagePreviewView(image: $img)
}
