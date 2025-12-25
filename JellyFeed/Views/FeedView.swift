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
                            isActive: index == vm.currentIndex,
                            onComplete: {
                                vm.moveToNextVideo()
                            }
                        )
                        .frame(height: UIScreen.main.bounds.height)
                        .id(index)
                    }
                }
            }
        }
        .task { await vm.loadFeed() }
    }
}
