import XCTest
@testable import Domain

final class BreathingStateTests: XCTestCase {
    
    func testStateSequence() {
        let states = BreathingState.allCases
        let expectedNextStates: [BreathingState] = [.initial, .inhaling, .holding, .exhaling, .inhaling]

        for i in 0..<states.count {
            XCTAssertTrue(states[i].nextState == expectedNextStates[i])
        }
    }
    
    func testDuration() {
        let states = BreathingState.allCases
        let expectedDurations: [Double] = [0.5, 1.5, 3, 1, 6]
        
        for i in 0..<states.count {
            XCTAssertTrue(states[i].duration == expectedDurations[i])
        }
    }
    
}
