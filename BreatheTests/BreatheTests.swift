//
//  BreatheTests.swift
//  BreatheTests
//
//  Created by Andreas Lif on 2023-08-15.
//

import XCTest
@testable import Breathe

final class BreatheTests: XCTestCase {

    func testSomething() {
        let vm = HomeViewModel()
        vm.repeatMode = .finite
        vm.numberOfRepetitions = 5
    }
    
}
