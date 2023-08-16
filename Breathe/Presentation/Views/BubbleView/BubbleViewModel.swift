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

    func size(for state: BreathingState) -> CGFloat {
        switch state {
        case .stopped:
            return 100
        case .initial:
            return 50
        case .inhaling:
            return 350
        case .holding:
            return 350
        case .exhaling:
            return 50
        }
    }

}
