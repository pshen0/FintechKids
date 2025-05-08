//
//  BubbleAnimationView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 01.04.2025.
//

import SwiftUI

struct Bubble: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
    var opacity: Double
}

struct BubbleAnimationView: View {
    private var bubbles: [Bubble] = (0..<25).map { _ in
        Bubble(
            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
            y: CGFloat.random(in: UIScreen.main.bounds.height / 2...UIScreen.main.bounds.height),
            size: CGFloat.random(in: 20...80),
            speed: CGFloat.random(in: 5...50),
            opacity: Double.random(in: 0.6...0.9)
        )
    }
    
    var body: some View {
        ZStack {
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    let currentTime = timeline.date.timeIntervalSinceReferenceDate
                    
                    for bubble in bubbles {
                        var newY = bubble.y - CGFloat(currentTime * bubble.speed).truncatingRemainder(dividingBy: UIScreen.main.bounds.height)
                        
                        if newY < -bubble.size {
                            newY += UIScreen.main.bounds.height + bubble.size
                        }
                        
                        let bubbleRect = CGRect(x: bubble.x, y: newY, width: bubble.size, height: bubble.size)
                        context.fill(
                            Path(ellipseIn: bubbleRect),
                            with: .radialGradient(
                                Gradient(colors: [Color.clear, Color.white.opacity(bubble.opacity)]),
                                center: bubbleRect.center,
                                startRadius: 0,
                                endRadius: bubble.size / 2
                            )
                        )
                    }
                }
            }
        }
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
