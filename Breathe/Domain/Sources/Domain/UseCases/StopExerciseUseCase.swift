//
//  StopExerciseUseCase.swift
//  Domain
//
//  Created by Andreas Lif on 2023-08-17.
//

import Combine
import Foundation

public struct StopExerciseUseCase {
    var exerciseManager: ExerciseManager = .shared
    
    public init() { }
    
    public func execute() {
        exerciseManager.stopExercise()
    }
}
