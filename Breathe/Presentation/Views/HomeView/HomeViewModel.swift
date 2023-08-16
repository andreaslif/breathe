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
    
    var backgroundOpacity: Double {
        switch state {
        case .stopped:
            return 0.4
        case .initial:
            return 0.4
        case .inhaling:
            return 0.6
        case .holding:
            return 0.6
        case .exhaling:
            return 0.4
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
            state = .initial
            scheduleStateChange()
        default:
            state = .stopped
        }
    }
    
    func scheduleStateChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + state.duration) { [weak self] in
            guard let self,
                  state != .stopped else { return }
            
            self.setNextState()
            
            guard state != .stopped else { return }
            
            self.scheduleStateChange()
        }
    }
    
    func setNextState() {
        if let nextState = BreathingState(rawValue: state.rawValue + 1),
           nextState != .initial {
            state = nextState
        } else {
            state = .inhaling
        }
    }
}
