//
//  FlipEffect.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct FlipOpacity: Animatable, ViewModifier {
   var percentage: CGFloat = 0
   
   var animatableData: CGFloat {
      get { percentage }
      set { percentage = newValue }
   }
   
   func body(content: Content) -> some View {
      content
           .opacity(Double(percentage.rounded()))
   }
}
