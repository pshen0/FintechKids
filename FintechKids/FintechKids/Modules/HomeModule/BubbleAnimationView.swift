//
//  BubbleAnimationView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 01.04.2025.
//


import SwiftUI

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    let creationTime: TimeInterval
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
    var opacity: Double
}

struct BubbleView: View {
    let bubble: Bubble
    let onTap: () -> Void
    let currentTime: TimeInterval
    
    var body: some View {
        
        let finalY = countYPosition(bubble: bubble, currentTime: currentTime)
        
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [Color.clear, Color.white.opacity(bubble.opacity)]),
                    center: .center,
                    startRadius: 0,
                    endRadius: bubble.size / 2
                )
            )
            .frame(width: bubble.size, height: bubble.size)
            .position(x: bubble.x, y: finalY)
            .onTapGesture {
                onTap()
            }
    }
}

/*struct PoppedBubbleView: View {
    @State var bubble: Bubble
    let currentTime: TimeInterval

    var body: some View {
        
        let finalY = countYPosition(bubble: bubble, currentTime: currentTime)
        
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [Color.clear, Color.white.opacity(bubble.opacity)]),
                    center: .center,
                    startRadius: 0,
                    endRadius: bubble.size / 2
                )
            )
            .frame(width: bubble.size, height: bubble.size)
            .position(x: bubble.x, y: finalY)
            .onAppear {
                withAnimation(.easeOut(duration: 0.4)) {
                    bubble.opacity = 0
                }
            }
    }
}*/

struct BubbleAnimationView: View {
    static var i = 0
    @State private var bubbles: [Bubble] = (0..<25).map { _ in
        generateBubble("initial")
    }
    
    @State private var poppedBubbles: [Bubble] = []
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let currentTime = timeline.date.timeIntervalSinceReferenceDate
            ZStack {
                ForEach(bubbles) { bubble in
                    BubbleView(bubble: bubble, onTap: {
                        if let index = bubbles.firstIndex(of: bubble) {
                            let popped = bubble
                            poppedBubbles.append(popped)
                            
                            bubbles.remove(at: index)
                            bubbles.append(generateBubble("deleted"))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                poppedBubbles.removeAll { $0.id == popped.id }
                            }
                        }
                    }, currentTime: currentTime)
                    /*
                    ForEach(poppedBubbles) { popped in
                        PoppedBubbleView(bubble: popped, currentTime: currentTime)
                    }*/
                }
            }
        }
    }
}

private func generateBubble(_ creation: String) -> Bubble {
    let topY = creation == "initial" ? 0 : UIScreen.main.bounds.height * (2/3)
    return Bubble(
        creationTime: Date().timeIntervalSinceReferenceDate,
        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
        y: CGFloat.random(in: topY...UIScreen.main.bounds.height),
        size: CGFloat.random(in: 20...80),
        speed: CGFloat.random(in: 5...50),
        opacity: Double.random(in: 0.6...0.8))
}

private func countYPosition(bubble: Bubble, currentTime: TimeInterval) -> CGFloat {
    let elapsed = currentTime - bubble.creationTime
    let totalOffset = CGFloat(elapsed * bubble.speed)
    let screenHeight = UIScreen.main.bounds.height
    
    let adjustedY = (bubble.y - totalOffset).truncatingRemainder(dividingBy: screenHeight + bubble.size)
    
    let finalY = adjustedY < -bubble.size
    ? adjustedY + screenHeight + bubble.size
    : adjustedY
    
    return finalY
}
