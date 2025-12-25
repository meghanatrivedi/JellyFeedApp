//
//  VideoPlayerView.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let video: VideoModel
    let isActive: Bool

    @StateObject private var vm: VideoPlayerViewModel

    init(video: VideoModel, isActive: Bool) {
        self.video = video
        self.isActive = isActive
        _vm = StateObject(
            wrappedValue: VideoPlayerViewModel(url: video.videoURL)
        )
    }

    var body: some View {
        ZStack {
            // 🎥 Video
            VideoPlayer(player: vm.player)
                .ignoresSafeArea()
                .allowsHitTesting(false)

            // 🧾 Overlay (UI only, no gesture blocking)
            VideoOverlayView(video: video)
                .allowsHitTesting(false)

            // 👆 Gesture layer (top-most, invisible)
            GestureHandlerView(playerVM: vm)
        }
        .onAppear {
            if isActive {
                vm.play()
            }
        }
        .onChange(of: isActive) { active in
            active ? vm.play() : vm.pause()
        }
        .onDisappear {
            vm.pause()
        }
    }
}
