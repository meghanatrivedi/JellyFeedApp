//
//  VideoOverlayView.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import SwiftUI

struct VideoOverlayView: View {
    let video: VideoModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("@\(video.uploader)")
                        .bold()
                    Text("⏱ \(Int(video.duration))s")
                        .font(.caption)
                }
                .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}
