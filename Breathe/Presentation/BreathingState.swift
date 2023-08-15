//
//  BreathingState.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Foundation

enum BreathingState: Int, Equatable, CaseIterable {
    case stopped = 0
    case initial
    case inhaling
    case holding
    case exhaling
    
    var duration: Double {
        switch self {
        case .stopped:
            return 0.5
        case .initial:
            return 1.5
        case .inhaling:
            return 3
        case .holding:
            return 1
        case .exhaling:
            return 6
        }
    }
}
