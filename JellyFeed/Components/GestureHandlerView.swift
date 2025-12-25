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
            .gesture(
                LongPressGesture(minimumDuration: 0.2)
                    .onChanged { _ in
                        playerVM.pause()
                    }
                    .onEnded { _ in
                        playerVM.play()
                    }
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.1)
                    .sequenced(before: DragGesture(minimumDistance: 0))
                    .onChanged { value in
                        switch value {
                        case .second(true, let drag):
                            if let location = drag?.location, location.x > UIScreen.main.bounds.width * 0.7 {
                                playerVM.setRate(2.0)
                            }
                        default: break
                        }
                    }
                    .onEnded { _ in
                        playerVM.setRate(1.0)
                    }
            )
    }
}

