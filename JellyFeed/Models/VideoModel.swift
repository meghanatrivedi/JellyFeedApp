//
//  VideoModel.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation
import AVFoundation

// MARK: - Models
struct VideoModel: Identifiable, Equatable {
    let id: String
    let videoURL: URL
    let uploader: String
    var duration: Double
}

