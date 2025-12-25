//
//  VideoPlayerViewModel.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation
import AVFoundation
import Combine   // ✅ REQUIRED

final class VideoPlayerViewModel: ObservableObject {   // ✅ Conforms now

    let player: AVPlayer

    @Published var isPlaying: Bool = false   // ✅ Published property

    init(url: URL) {
        self.player = AVPlayer(url: url)
        self.player.isMuted = true
        
        // Add Looping support
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: self.player.currentItem,
            queue: .main
        ) { [weak self] _ in
            self?.player.seek(to: .zero)
            self?.player.play()
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
    }
}
