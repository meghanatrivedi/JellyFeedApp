//
//  JellyFeedService.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation
import AVFoundation

// MARK: - Service
final class JellyFeedService {
    private let feedURL = URL(string: "https://api.jellyjelly.com/feed")!

    func fetchFeed() async throws -> [VideoModel] {
        let response: FeedResponse = try await APIClient.fetch(url: feedURL)
        
        // Load metadata (durations) in parallel
        return await withTaskGroup(of: VideoModel?.self) { group in
            for item in response.feed {
                group.addTask {
                    let asset = AVAsset(url: item.jelly.videoURL)
                    let duration = await asset.loadDuration()
                    return VideoModel(
                        id: item.jelly.id,
                        videoURL: item.jelly.videoURL,
                        uploader: item.jelly.participants.first?.username ?? "unknown",
                        duration: duration
                    )
                }
            }
            
            var results: [VideoModel] = []
            for await video in group {
                if let v = video { results.append(v) }
            }
            return results
        }
    }
}
