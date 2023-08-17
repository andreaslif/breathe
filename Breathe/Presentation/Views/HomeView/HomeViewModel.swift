//
//  HomeViewModel.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Combine
import Domain
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var state: BreathingState = .stopped
    @Published var repeatMode: RepeatMode = .finite
    @Published var repetitionCount: Int = 0
    @Published var numberOfRepetitions: Int = 10
    
    private var cancellables = Set<AnyCancellable>()
    
    private let subscribeToBreathingStateUseCase = SubscribeToBreathingStateUseCase()
    private let subscribeToRepetitionCountUseCase = SubscribeToRepetitionCountUseCase()
    private let startExerciseUseCase = StartExerciseUseCase()
    private let stopExerciseUseCase = StopExerciseUseCase()
    private let setNumberOfRepetitionsUseCase = SetNumberOfRepetitionsUseCase()
    private let setRepeatModeUseCase = SetRepeatModeUseCase()
    
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
        (state == .inhaling || state == .holding) ? 0.2 : 0
    }
    
    var exerciseButtonBackgroundColor: Color {
        state == .stopped ? .accentOne : Color.blackWhite.opacity(0.5)
    }
    
    var buttonText: String {
        state == .stopped ? Copy.HomeView.start : Copy.HomeView.stop
    }
    
    init() {
        subscribeToBreathingStateUseCase.execute()
            .assign(to: &$state)
        
        subscribeToRepetitionCountUseCase.execute()
            .assign(to: &$repetitionCount)
        
        $numberOfRepetitions
            .sink { self.setNumberOfRepetitionsUseCase.execute(with: $0) }
            .store(in: &cancellables)
        
        $repeatMode
            .sink { self.setRepeatModeUseCase.execute(with: $0) }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func toggleExercise() {
        state == .stopped
        ? startExerciseUseCase.execute()
        : stopExerciseUseCase.execute()
    }
    
}
