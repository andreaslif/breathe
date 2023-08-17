//
//  HomeView.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import Domain
import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            background()
            
            CircularPatternView(totalSteps: vm.numberOfRepetitions, size: 300, numberOfStepsToShow: $vm.repetitionCount)
                .opacity(vm.countdownOpacity)
                .animation(.easeInOut(duration: 1), value: vm.state)
            
            BubbleView(state: $vm.state)
                .padding(16)
            
            ConfigView(repeatMode: $vm.repeatMode, numberOfRepetitions: $vm.numberOfRepetitions)
                .opacity(vm.configViewOpacity)
                .animation(.easeInOut(duration: 1), value: vm.state)
                .animation(.easeInOut(duration: 0.25), value: vm.repeatMode)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(16)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: .zero) {
                Text(vm.instructions)
                    .font(.title2.bold())
                    .foregroundStyle(Color.grayOne)
                    .padding(.top, 100)
                    .animation(.easeInOut(duration: 1), value: vm.instructions)
                
                Spacer()
                
                Button(action: vm.toggleExercise) {
                    ZStack {
                        Capsule(style: .continuous)
                            .foregroundStyle(vm.exerciseButtonBackgroundColor)
                        Text(vm.buttonText)
                            .foregroundStyle(Color.white)
                    }
                    .frame(maxWidth: 200, maxHeight: 54)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
}

extension HomeView {
    @ViewBuilder func background() -> some View {
        Color.backgroundOne
            .edgesIgnoringSafeArea(.all)
            .overlay {
                Color.teal.opacity(vm.backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: vm.state.duration), value: vm.state)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
