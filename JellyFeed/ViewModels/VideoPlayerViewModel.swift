//
//  VideoPlayerViewModel.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation
import AVFoundation
import Combine

final class VideoPlayerViewModel: ObservableObject {
    let player: AVPlayer
    
    @Published var isPlaying: Bool = false
    @Published var isFastForwarding: Bool = false
    
    var onVideoEnded: (() -> Void)?

    init(url: URL) {
            self.player = AVPlayer(url: url)
            self.player.isMuted = true
            
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: self.player.currentItem,
                queue: .main
            ) { [weak self] _ in
                self?.onVideoEnded?()
            }
        }

    func play() {
        player.play()
        isPlaying = true
    }

    func pause() {
        player.pause()
        isPlaying = false
    }

    func setRate(_ rate: Float) {
        player.rate = rate
        isFastForwarding = (rate > 1.0)
    }
}
