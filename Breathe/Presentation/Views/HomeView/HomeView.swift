//
//  HomeView.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            background()
            
            BubbleView(state: $vm.state)
            
            ConfigView(repeatMode: $vm.repeatMode,
                       numberOfRepetitions: $vm.numberOfRepetitions)
                .opacity(vm.testOpacity)
                .animation(.easeInOut(duration: 1), value: vm.state)
                .animation(.easeInOut(duration: 0.25), value: vm.repeatMode)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(16)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: .zero) {
                Text(vm.instructions)
                    .font(.title2.bold())
                    .foregroundStyle(Color.black.opacity(0.6))
                    .padding(.top, 100)
                    .animation(.easeInOut(duration: 1), value: vm.instructions)
                
                Spacer()
                
                Button(action: vm.toggleExercise) {
                    ZStack {
                        Capsule(style: .continuous)
                            .foregroundStyle(Color.black.opacity(0.5))
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
        Color.teal.opacity(vm.backgroundOpacity)
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut(duration: vm.state.duration), value: vm.state)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
