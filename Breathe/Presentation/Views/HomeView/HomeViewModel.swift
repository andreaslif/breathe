//
//  HomeViewModel.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var state: BreathingState = .stopped
    @Published var repeatMode: RepeatMode = .finite
    @Published var isContinuousOn = false
    @Published var exerciseCount: Int = 0
    @Published var numberOfRepetitions: Int = 10
    
    /// In order to display the correct number of exercises remaining,
    /// while also closing the `BubbleView`at the correct time when the last exercise finishes,
    /// we use this flag to skip the first decrementation of the `exerciseCount`.
    var isFirstExerciseCountDecrement = true
    var stateChangeTimer: Timer?
    
    var instructions: String {
        switch state {
        case .stopped:
            return Copy.HomeView.stopped
        case .initial:
            return ""
        case .inhaling:
            return Copy.HomeView.inhaling
        case .holding:
            return ""
        case .exhaling:
            return Copy.HomeView.exhaling
        }
    }
    
    var configViewOpacity: Double {
        state == .stopped ? 1 : 0
    }
    
    var countdownOpacity: Double {
        (repeatMode == .finite && state != .stopped) ? 1 : 0
    }
    
    var backgroundOpacity: Double {
        switch state {
        case .stopped:
            return 0
        case .initial:
            return 0
        case .inhaling:
            return 0.2
        case .holding:
            return 0.2
        case .exhaling:
            return 0
        }
    }
    
    var exerciseButtonBackgroundColor: Color {
        switch state {
        case .stopped:
            return .accentOne
        default:
            return Color.blackWhite.opacity(0.5)
        }
    }
    
    var buttonText: String {
        switch state {
        case .stopped:
            return Copy.HomeView.start
        default:
            return Copy.HomeView.stop
        }
    }
    
    func toggleExercise() {
        switch state {
        case .stopped:
            startExercise()
        default:
            stopExercise()
        }
    }
    
}

// MARK: - Private Functions

private extension HomeViewModel {
    
    func startExercise() {
        resetExerciseCount()
        state = .initial
        scheduleStateChange()
    }
    
    func resetExerciseCount() {
        exerciseCount = numberOfRepetitions
    }
    
    func stopExercise() {
        state = .stopped
        resetStateChangeTimer()
        resetInitialConditions()
    }
    
    func resetStateChangeTimer() {
        stateChangeTimer?.invalidate()
        stateChangeTimer = nil
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
        
        setNextState()
        handleExerciseCount()
        
        guard state != .stopped else { return }
        
        scheduleStateChange()
    }
    
    func setNextState() {
        if let nextState = BreathingState(rawValue: state.rawValue + 1),
           nextState != .initial {
            state = nextState
        } else {
            state = .inhaling
        }
    }
    
    func handleExerciseCount() {
        guard repeatMode == .finite else { return }
        
        guard !isFirstExerciseCountDecrement else {
            isFirstExerciseCountDecrement = false
            return
        }
        
        if state == .inhaling {
            exerciseCount -= 1
            
            if exerciseCount == 0 { stopExercise() }
        }
    }
    
}
