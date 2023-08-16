//
//  RepeatMode.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-16.
//

import Foundation

enum RepeatMode: Int, CaseIterable, Identifiable {
    var id: Self { self }
    
    case finite = 0
    case infinite
    
    var title: String {
        switch self {
        case .finite:
            return Copy.RepeatMode.finite
        case .infinite:
            return Copy.RepeatMode.infinite
        }
    }
}
