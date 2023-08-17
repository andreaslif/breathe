//
//  RepeatMode.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-16.
//

import Foundation

public enum RepeatMode: Int, CaseIterable, Identifiable {
    public var id: Self { self }
    
    case finite = 0
    case infinite
}
