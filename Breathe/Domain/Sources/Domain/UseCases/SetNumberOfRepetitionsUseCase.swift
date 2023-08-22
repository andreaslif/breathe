//
//  SetNumberOfRepetitionsUseCase.swift
//  Domain
//
//  Created by Andreas Lif on 2023-08-17.
//

import Foundation

public struct SetNumberOfRepetitionsUseCase {
    let exerciseManager: ExerciseManager = .shared
    
    public init() {}
    
    public func execute(with numberOfRepetitions: Int) {
        exerciseManager.numberOfRepetitions = numberOfRepetitions
    }
}
