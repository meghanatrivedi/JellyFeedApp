//
//  LoadingView.swift
//  JellyFeed
//
//  Created by Meggi on 25/12/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.2), .white],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(
                        .linear(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: isAnimating
                    )

                Text("Loading feed…")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.footnote)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    LoadingView()
}
