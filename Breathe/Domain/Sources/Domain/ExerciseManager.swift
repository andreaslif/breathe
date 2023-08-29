//
//  ExerciseManager.swift
//  Domain
//
//  Created by Andreas Lif on 2023-08-17.
//

import Combine
import Foundation

final class ExerciseManager: ObservableObject {
    static let shared = ExerciseManager()
    
    @Published var state: BreathingState = .stopped
    @Published var repeatMode: RepeatMode = .finite
    @Published var repetitionCount: Int = 0
    @Published var numberOfRepetitions: Int = 10

    var stateChangeTimer: Timer? {
        willSet { stateChangeTimer?.invalidate() }
    }
    
    func startExercise() {
        resetExerciseCount()
        state = .initial
        scheduleStateChange(isFirstPass: true)
    }
    
    func stopExercise() {
        state = .stopped
        stateChangeTimer = nil
    }

}

// MARK: - Private Functions

private extension ExerciseManager {
    
    func resetExerciseCount() {
        repetitionCount = numberOfRepetitions
    }

    func scheduleStateChange(isFirstPass: Bool = false) {
        stateChangeTimer = Timer.scheduledTimer(withTimeInterval: state.duration, repeats: false) { [weak self] _ in
            guard let self else { return }
            
            self.handleStateIncrementation(isFirstPass: isFirstPass)
        }
    }
    
    func handleStateIncrementation(isFirstPass: Bool) {
        guard state != .stopped else { return }
        
        state = state.nextState
        
        // The first pass is ignored, so that `exerciseCount` isn't decremented immediately.
        handleRepetitionCount(shouldIgnorePass: isFirstPass)
        
        guard state != .stopped else { return }
        
        scheduleStateChange()
    }
    
    func handleRepetitionCount(shouldIgnorePass: Bool) {
        guard repeatMode == .finite, !shouldIgnorePass
        else { return }
        
        if state == .inhaling { repetitionCount -= 1 }
        if repetitionCount == 0 { stopExercise() }
    }
    
}
