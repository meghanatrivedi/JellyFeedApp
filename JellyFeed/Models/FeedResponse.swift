//
//  FeedResponse.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//
import Foundation

struct FeedResponse: Decodable {
    let status: String
    let lastUpdated: String
    let feed: [FeedItem]

    enum CodingKeys: String, CodingKey {
        case status
        case lastUpdated = "last_updated"
        case feed
    }
}

struct FeedItem: Decodable {
    let contentType: String
    let jelly: JellyItem

    enum CodingKeys: String, CodingKey {
        case contentType = "content_type"
        case jelly
    }
}

struct JellyItem: Decodable {
    let id: String
    let videoURL: URL
    let participants: [Participant]

    enum CodingKeys: String, CodingKey {
        case id
        case videoURL = "video_url"
        case participants
    }
}

struct Participant: Decodable {
    let username: String
}
