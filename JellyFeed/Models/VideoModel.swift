//
//  VideoModel.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation

struct VideoModel: Identifiable {
    let id: String
    let videoURL: URL
    let uploader: String
    let duration: Double
}
