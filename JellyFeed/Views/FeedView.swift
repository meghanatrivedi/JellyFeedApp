//
//  FeedView.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var vm = FeedViewModel()

    var body: some View {
        ZStack {
            if vm.videos.isEmpty {
                LoadingView()
            } else {
                VerticalPager(index: $vm.currentIndex) {
                    ForEach(Array(vm.videos.enumerated()), id: \.offset) { index, video in
                        VideoPlayerView(
                            video: video,
                            isActive: index == vm.currentIndex
                        )
                        .frame(height: UIScreen.main.bounds.height) // ✅ full page
                        .id(index) // ✅ THIS IS THE KEY
                    }
                }
            }
        }
        .task {
            await vm.loadFeed()
        }
        .onChange(of: vm.currentIndex) { _ in
            vm.prefetch()
        }
    }
}
