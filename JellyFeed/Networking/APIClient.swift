//
//  APIClient.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import Foundation

final class APIClient {
    static func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
