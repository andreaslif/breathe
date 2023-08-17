//
//  UseCasesTests.swift
//  BreatheTests
//
//  Created by Andreas Lif on 2023-08-17.
//

import Combine
import XCTest
@testable import Domain

final class UseCasesTests: XCTestCase {
    
    override func tearDown() {
        ExerciseManager.shared.stopExercise()
        ExerciseManager.shared.repeatMode = .finite
        ExerciseManager.shared.numberOfRepetitions = 10
    }
    
    func testSetNumberOfRepetitionsUseCase() {
        let useCase = SetNumberOfRepetitionsUseCase()
        XCTAssertFalse(ExerciseManager.shared.numberOfRepetitions == 5)
        useCase.execute(with: 5)
        XCTAssertTrue(ExerciseManager.shared.numberOfRepetitions == 5)
    }
    
    func testSetRepeatModeUseCase() {
        let useCase = SetRepeatModeUseCase()
        XCTAssertFalse(ExerciseManager.shared.repeatMode == .infinite)
        useCase.execute(with: .infinite)
        XCTAssertTrue(ExerciseManager.shared.repeatMode == .infinite)
    }
    
    func testStartExerciseUseCase() {
        let useCase = StartExerciseUseCase()
        XCTAssertTrue(ExerciseManager.shared.state == .stopped)
        useCase.execute()
        XCTAssertFalse(ExerciseManager.shared.state == .stopped)
    }
    
    func testStopExerciseUseCase() {
        let useCase = StopExerciseUseCase()
        ExerciseManager.shared.startExercise()
        XCTAssertFalse(ExerciseManager.shared.state == .stopped)
        useCase.execute()
        XCTAssertTrue(ExerciseManager.shared.state == .stopped)
    }
    
    func testSubscribeToBreathingStateUseCase() {
        let useCase = SubscribeToBreathingStateUseCase()
        ExerciseManager.shared.stopExercise()
        let _ = useCase.execute()
            .sink { XCTAssert($0 == .stopped) }
    }
    
    func testSubscribeTo() {
        let useCase = SubscribeToRepetitionCountUseCase()
        ExerciseManager.shared.numberOfRepetitions = 5
        ExerciseManager.shared.startExercise()
        let _ = useCase.execute()
            .sink { XCTAssert($0 == 5) }
    }
    
}
