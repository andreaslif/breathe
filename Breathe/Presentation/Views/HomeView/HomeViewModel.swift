//
//  HomeViewModel.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Domain
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
    private var isFirstExerciseCountDecrement = true
    private var stateChangeTimer: Timer? {
        willSet { stateChangeTimer?.invalidate() }
    }
    
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
    //TODO: test input/output of this without needing a view
    var configViewOpacity: Double {
        state == .stopped ? 1 : 0
    }
    
    var countdownOpacity: Double {
        (repeatMode == .finite && state != .stopped) ? 1 : 0
    }
    
    var backgroundOpacity: Double {
        (state == .inhaling || state == .holding) ? 0.2 : 0
    }
    
    var exerciseButtonBackgroundColor: Color {
        state == .stopped ? .accentOne : Color.blackWhite.opacity(0.5)
    }
    
    var buttonText: String {
        state == .stopped ? Copy.HomeView.start : Copy.HomeView.stop
    }
    
    func toggleExercise() {
        state == .stopped ? startExercise() : stopExercise()
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
        stateChangeTimer = nil
        resetInitialConditions()
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
    
    // TODO: Test HomeViewModel state changes, circles disappear correctly etc.
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
