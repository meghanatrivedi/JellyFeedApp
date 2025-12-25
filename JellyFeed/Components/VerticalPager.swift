//
//  VerticalPager.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import SwiftUI

struct VerticalPager<Content: View>: View {
    @Binding var index: Int
    let content: () -> Content

    @State private var scrollPosition: Int?

    init(
        index: Binding<Int>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._index = index
        self.content = content
        self._scrollPosition = State(initialValue: index.wrappedValue)
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    content()
                }
                .scrollTargetLayout() // ✅ REQUIRED
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $scrollPosition)
            .onChange(of: scrollPosition) { newValue in
                guard let newValue else { return }
                index = newValue
            }
            .onChange(of: index) { newValue in
                scrollPosition = newValue
            }
        }
    }
}
