//
//  BreathingState.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Foundation

public enum BreathingState: Int, Equatable, CaseIterable {
    case stopped = 0
    case initial
    case inhaling
    case holding
    case exhaling
    
    public var duration: Double {
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
    
    public var nextState: BreathingState {
        guard let next = BreathingState(rawValue: self.rawValue + 1)
        else { return .inhaling }
        
        return next
    }
}
