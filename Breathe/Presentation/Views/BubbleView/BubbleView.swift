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
                    .frame(maxWidth: vm.size(for: state))
            }
        }
        .animation(.easeInOut(duration: state.duration), value: state)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(state: .constant(.inhaling))
    }
}
