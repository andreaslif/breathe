//
//  BubbleView.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Domain
import SwiftUI

struct BubbleView: View {
    @Binding var state: BreathingState
    
    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                Circle()
                    .foregroundStyle(
                        Color.teal.opacity(0.5)
                            .opacity(state.backgroundOpacity)
                    )
                    .scaleEffect(state.scale)
            }
        }
        .animation(.easeInOut(duration: state.duration), value: state)
    }
}

private extension BreathingState {
    var backgroundOpacity: Double {
        switch self {
        case .stopped:
            return 0
        case .initial, .exhaling:
            return 0.25
        case .inhaling, .holding:
            return 0.75
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .stopped:
            return 0.3
        case .initial, .exhaling:
            return 0.15
        case .inhaling, .holding:
            return 1
        }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(state: .constant(.inhaling))
            .frame(maxWidth: 300)
    }
}
