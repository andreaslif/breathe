//
//  ExerciseManagerTests.swift
//  BreatheTests
//
//  Created by Andreas Lif on 2023-08-18.
//

import XCTest
@testable import Domain

final class ExerciseManagerTests: XCTestCase {
    
    override func tearDown() {
        ExerciseManager.shared.stopExercise()
        ExerciseManager.shared.repeatMode = .finite
        ExerciseManager.shared.numberOfRepetitions = 10
    }
    
    func testRepetitionCountDecrementation() {
        ExerciseManager.shared.numberOfRepetitions = 5
        ExerciseManager.shared.startExercise()
        XCTAssertTrue(ExerciseManager.shared.repetitionCount == 5)
        
        BreathingState.allCases.forEach { _ in
            ExerciseManager.shared.stateChangeTimer?.fire()
        }
        
        XCTAssertTrue(ExerciseManager.shared.repetitionCount == 4)
    }
    
    func testFiniteExerciseStop() {
        ExerciseManager.shared.numberOfRepetitions = 1
        ExerciseManager.shared.repeatMode = .finite
        ExerciseManager.shared.startExercise()
        
        BreathingState.allCases.forEach { _ in
            ExerciseManager.shared.stateChangeTimer?.fire()
        }
        
        XCTAssertTrue(ExerciseManager.shared.state == .stopped)
    }
    
    func testInfiniteExerciseContinuous() {
        ExerciseManager.shared.numberOfRepetitions = 1
        ExerciseManager.shared.repeatMode = .infinite
        ExerciseManager.shared.startExercise()
        
        BreathingState.allCases.forEach { _ in
            ExerciseManager.shared.stateChangeTimer?.fire()
        }
        
        XCTAssertFalse(ExerciseManager.shared.state == .stopped)
    }
    
}
