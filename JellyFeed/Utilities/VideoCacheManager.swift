//
//  VideoCacheManager.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import AVFoundation

final class VideoCacheManager {
    static let shared = VideoCacheManager()
    private init() {}

    func prefetch(url: URL) {
        let asset = AVURLAsset(url: url)
        asset.loadValuesAsynchronously(forKeys: ["playable"])
    }
}
