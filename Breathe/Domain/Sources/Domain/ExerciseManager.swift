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
    
    /// In order to display the correct number of exercises remaining,
    /// while also closing the `BubbleView`at the correct time when the last exercise finishes,
    /// we use this flag to skip the first decrementation of the `exerciseCount`.
    private var isFirstExerciseCountDecrement = true
    var stateChangeTimer: Timer? {
        willSet { stateChangeTimer?.invalidate() }
    }
    
    func startExercise() {
        resetExerciseCount()
        state = .initial
        scheduleStateChange()
    }
    
    func stopExercise() {
        state = .stopped
        stateChangeTimer = nil
        resetInitialConditions()
    }

}

// MARK: - Private Functions

private extension ExerciseManager {
    
    func resetExerciseCount() {
        repetitionCount = numberOfRepetitions
    }
    
    func resetInitialConditions() {
        isFirstExerciseCountDecrement = true
    }
    
    func scheduleStateChange() {
        stateChangeTimer = Timer.scheduledTimer(
            timeInterval: state.duration,
            target: self,
            selector: #selector(handleStateIncrementation),
            userInfo: nil,
            repeats: false)
    }
    
    @objc func handleStateIncrementation() {
        guard state != .stopped else { return }
        
        state = state.nextState
        handleExerciseCount()
        
        guard state != .stopped else { return }
        
        scheduleStateChange()
    }
    
    func handleExerciseCount() {
        guard repeatMode == .finite else { return }
        
        guard !isFirstExerciseCountDecrement else {
            isFirstExerciseCountDecrement = false
            return
        }
        
        if state == .inhaling {
            repetitionCount -= 1
            
            if repetitionCount == 0 { stopExercise() }
        }
    }
    
}
