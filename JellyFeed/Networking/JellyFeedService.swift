//
//  JellyFeedService.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation
import AVFoundation

final class JellyFeedService {

    private let feedURL = URL(string: "https://api.jellyjelly.com/feed")!

    func fetchFeed() async throws -> [VideoModel] {
        let response: FeedResponse = try await APIClient.fetch(url: feedURL)
        
        // We use a TaskGroup to load durations in parallel for speed
        return await withTaskGroup(of: VideoModel?.self) { group in
            for item in response.feed {
                group.addTask {
                    guard let uploader = item.jelly.participants.first?.username else { return nil }
                    let asset = AVAsset(url: item.jelly.videoURL)
                    let duration = await asset.loadDuration() // Use your extension!
                    
                    return VideoModel(
                        id: item.jelly.id,
                        videoURL: item.jelly.videoURL,
                        uploader: uploader,
                        duration: duration
                    )
                }
            }
            
            var results: [VideoModel] = []
            for await video in group {
                if let video = video { results.append(video) }
            }
            return results
        }
    }
}
