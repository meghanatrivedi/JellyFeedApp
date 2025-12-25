//
//  GestureHandlerView.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import SwiftUI

struct GestureHandlerView: View {
    @ObservedObject var playerVM: VideoPlayerViewModel

    var body: some View {
        Color.clear
            .contentShape(Rectangle())
            // Detect long press to pause
            .onLongPressGesture(minimumDuration: 0.2, pressing: { isPressing in
                if isPressing {
                    playerVM.pause()
                } else {
                    playerVM.play()
                    playerVM.setRate(1.0) // Reset speed if they were fast-forwarding
                }
            }, perform: {})
            // Simultaneous gesture for the 2x speed on the right side
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if value.location.x > UIScreen.main.bounds.width * 0.7 {
                            playerVM.setRate(2.0)
                        }
                    }
                    .onEnded { _ in
                        playerVM.setRate(1.0)
                    }
            )
    }
}
