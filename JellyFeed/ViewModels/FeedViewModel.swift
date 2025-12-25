//
//  FeedViewModel.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {

    @Published var videos: [VideoModel] = []
    @Published var currentIndex: Int = 0  

    private let service = JellyFeedService()

    func loadFeed() async {
        do {
            videos = try await service.fetchFeed()
            prefetch()
        } catch {
            print("Feed error:", error)
        }
    }

    func prefetch() {
        let start = currentIndex
        let end = min(currentIndex + Constants.prefetchCount, videos.count)

        guard start < end else { return }

        for index in start..<end {
            VideoCacheManager.shared.prefetch(url: videos[index].videoURL)
        }
    }
    
    func moveToNextVideo() {
            if currentIndex < videos.count - 1 {
                withAnimation(.spring()) {
                    currentIndex += 1
                }
            }
        }
}
