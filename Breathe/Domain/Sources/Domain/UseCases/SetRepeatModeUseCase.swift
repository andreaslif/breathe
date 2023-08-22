//
//  SetRepeatModeUseCase.swift
//  Domain
//
//  Created by Andreas Lif on 2023-08-17.
//

import Combine
import Foundation

public struct SetRepeatModeUseCase {
    let exerciseManager: ExerciseManager = .shared
    
    public init() { }
    
    public func execute(with repeatMode: RepeatMode) {
        exerciseManager.repeatMode = repeatMode
    }
}
