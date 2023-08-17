//
//  SubscribeToRepetitionCountUseCase.swift
//  Domain
//
//  Created by Andreas Lif on 2023-08-17.
//

import Combine
import Foundation

public struct SubscribeToRepetitionCountUseCase {
    var exerciseManager: ExerciseManager = .shared
    
    public init() { }
    
    public func execute() -> AnyPublisher<Int, Never> {
        exerciseManager.$repetitionCount.eraseToAnyPublisher()
    }
}
