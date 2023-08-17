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
        print(#function)
        let vm = HomeViewModel()
        XCTAssertTrue(vm.state == .stopped)
        vm.toggleExercise()
        XCTAssertFalse(vm.state == .stopped)
        vm.toggleExercise()
        XCTAssertTrue(vm.state == .stopped)
    }
    
    func testSetNumberOfRepetitions() {
        print(#function)
        let vm = HomeViewModel()
        XCTAssertFalse(vm.numberOfRepetitions == 5)
        vm.numberOfRepetitions = 5
        XCTAssertTrue(vm.numberOfRepetitions == 5)
    }
    
    func testInitialRepetitionCount() {
        print(#function)
        let vm = HomeViewModel()
        XCTAssertFalse(vm.repetitionCount == 5)
        vm.numberOfRepetitions = 5
        vm.toggleExercise()
        XCTAssertTrue(vm.repetitionCount == 5)
    }
    
    func testSetState() {
        print(#function)
        let vm = HomeViewModel()
        XCTAssertFalse(vm.repeatMode == .infinite)
        vm.repeatMode = .infinite
        XCTAssertTrue(vm.repeatMode == .infinite)
    }
    
}
