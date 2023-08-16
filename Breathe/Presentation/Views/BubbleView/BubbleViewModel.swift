//
//  BubbleViewModel.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Foundation
import SwiftUI

class BubbleViewModel: ObservableObject {
    
    let backgroundColor = Color.teal.opacity(0.5)
    
    func backgroundOpacity(for state: BreathingState) -> Double {
        switch state {
        case .stopped:
            return 0
        case .initial:
            return 0.25
        case .inhaling:
            return 0.75
        case .holding:
            return 0.75
        case .exhaling:
            return 0.25
        }
    }

    func scale(for state: BreathingState) -> CGFloat {
        switch state {
        case .stopped:
            return 0.3
        case .initial:
            return 0.15
        case .inhaling:
            return 1
        case .holding:
            return 1
        case .exhaling:
            return 0.15
        }
    }

}
