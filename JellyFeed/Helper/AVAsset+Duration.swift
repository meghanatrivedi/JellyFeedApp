//
//  AVAsset+Duration.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import AVFoundation

extension AVAsset {
    func loadDuration() async -> Double {
        do {
            let duration = try await load(.duration)
            return CMTimeGetSeconds(duration)
        } catch {
            return 0
        }
    }
}
