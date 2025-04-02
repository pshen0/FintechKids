//
//  FinikAvatar.swift
//  FintechKids
//
//  Created by Данил Забинский on 02.04.2025.
//

import SwiftUI

#Preview {
    FinikAvatar()
}

struct FinikAvatar: View {
    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(.clear)
                .frame(height: ChatConstants.finikAvatar.height)
                .overlay {
                    Image(.cat)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(Padding.small)
                }
                .background(
                    ZStack {
                        LinearGradient (
                            gradient: Gradient(stops: [
                                .init(color: .text, location: 0.2),
                                .init(color: .message, location: 0.6),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ).ignoresSafeArea()
                        
                        Color.white.opacity(0.15)
                    }
                )
                .clipShape(Circle())
        }
    }
}
