//
//  PhotoLink.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/23.
//

import SwiftUI

struct PhotoLink<Content: View>: View {
    @Namespace private var ns
    @Binding var image: UIImage?
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        NavigationLink {
            ImagePreviewView(image: $image)
                .navigationTransition(.zoom(sourceID: "previewImage", in: ns))
        } label: {
            content()
        }
        .buttonStyle(.plain)
        .matchedTransitionSource(id: "previewImage", in: ns)
    }
}
