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
    let onComplete: () -> Void
    
    @StateObject private var vm: VideoPlayerViewModel

    init(video: VideoModel, isActive: Bool, onComplete: @escaping () -> Void) {
        self.video = video
        self.isActive = isActive
        self.onComplete = onComplete
        _vm = StateObject(wrappedValue: VideoPlayerViewModel(url: video.videoURL))
    }

    var body: some View {
        ZStack {
            VideoPlayer(player: vm.player)
                .ignoresSafeArea()
            
            VideoOverlayView(video: video)
            
            GestureHandlerView(playerVM: vm)
        }
        .onAppear {
            vm.onVideoEnded = onComplete
            if isActive { vm.play() }
        }
        .onChange(of: isActive) { oldValue, newValue in
            newValue ? vm.play() : vm.pause()
        }
    }
}
