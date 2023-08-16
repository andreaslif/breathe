//
//  BubbleView.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import SwiftUI

struct BubbleView: View {
    @StateObject var vm = BubbleViewModel()
    @Binding var state: BreathingState
    
    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                Circle()
                    .foregroundStyle(
                        vm.backgroundColor
                            .opacity(vm.backgroundOpacity(for: state))
                    )
                    .scaleEffect(vm.scale(for: state))
            }
        }
        .animation(.easeInOut(duration: state.duration), value: state)
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(state: .constant(.inhaling))
            .frame(maxWidth: 300)
    }
}
