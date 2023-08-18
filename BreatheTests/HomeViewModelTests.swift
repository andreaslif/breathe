//
//  HomeViewModelTests.swift
//  BreatheTests
//
//  Created by Andreas Lif on 2023-08-15.
//

import XCTest
@testable import Domain
@testable import Breathe

final class HomeViewModelTests: XCTestCase {
    
    override func tearDown() {
        ExerciseManager.shared.stopExercise()
        ExerciseManager.shared.repeatMode = .finite
        ExerciseManager.shared.numberOfRepetitions = 10
    }
    
    func testStartStopExercise() {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.state == .stopped)
        vm.toggleExercise()
        XCTAssertFalse(vm.state == .stopped)
        vm.toggleExercise()
        XCTAssertTrue(vm.state == .stopped)
    }
    
    func testSetNumberOfRepetitions() {
        let vm = HomeViewModel()
        XCTAssertFalse(vm.numberOfRepetitions == 5)
        vm.numberOfRepetitions = 5
        XCTAssertTrue(vm.numberOfRepetitions == 5)
    }
    
    func testInitialRepetitionCount() {
        let vm = HomeViewModel()
        XCTAssertFalse(vm.repetitionCount == 5)
        vm.numberOfRepetitions = 5
        vm.toggleExercise()
        XCTAssertTrue(vm.repetitionCount == 5)
    }
    
    func testSetState() {
        let vm = HomeViewModel()
        XCTAssertFalse(vm.repeatMode == .infinite)
        vm.repeatMode = .infinite
        XCTAssertTrue(vm.repeatMode == .infinite)
    }
    
    func testConfigViewOpacity() {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.configViewOpacity == 1)
        vm.toggleExercise()
        XCTAssertTrue(vm.configViewOpacity == 0)
    }
    
    func testCountdownOpacityFiniteMode() {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.countdownOpacity == 0)
        vm.repeatMode = .finite
        vm.toggleExercise()
        XCTAssertTrue(vm.countdownOpacity == 1)
    }
    
    func testCountdownOpacityInfiniteMode() {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.countdownOpacity == 0)
        vm.repeatMode = .infinite
        vm.toggleExercise()
        XCTAssertTrue(vm.countdownOpacity == 0)
    }
    
    func testBackgroundOpacity() {
        let vm = HomeViewModel()
        let states = BreathingState.allCases
        let expectedOpacities = [0, 0, 0.2, 0.2, 0]
        
        for i in 0..<states.count {
            vm.state = states[i]
            XCTAssertTrue(vm.state == states[i])
            XCTAssertTrue(vm.backgroundOpacity == expectedOpacities[i])
        }
    }
    
    func testExerciseButtonBackgroundColorStopped() {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.state == .stopped)
        XCTAssertTrue(vm.exerciseButtonBackgroundColor == .accentOne)
    }
    
    func testExerciseButtonBackgroundColorStarted() {
        let vm = HomeViewModel()
        vm.toggleExercise()
        XCTAssertFalse(vm.state == .stopped)
        XCTAssertTrue(vm.exerciseButtonBackgroundColor == .blackWhite.opacity(0.5))
    }
    
    func testButtonTextStopped() {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.state == .stopped)
        XCTAssertTrue(vm.buttonText == Copy.HomeView.start)
    }
    
    func testButtonTextStarted() {
        let vm = HomeViewModel()
        vm.toggleExercise()
        XCTAssertFalse(vm.state == .stopped)
        XCTAssertTrue(vm.buttonText == Copy.HomeView.stop)
    }
    
}
