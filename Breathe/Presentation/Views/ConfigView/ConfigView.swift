//
//  ConfigView.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-16.
//

import SwiftUI

struct ConfigView: View {
    @Binding var repeatMode: RepeatMode
    @Binding var numberOfRepetitions: Int

    var body: some View {
        VStack(spacing: 16) {
            Picker("Mode", selection: $repeatMode) {
                ForEach(RepeatMode.allCases) { mode in
                    Text(mode.title).tag(mode.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .onAppear { overrideSegmentedPickerAppearance() }
            
            VStack(spacing: 8) {
                Text(Copy.ConfigView.exerciseText)
                ZStack {
                    Text(repeatMode == .finite
                         ? String(numberOfRepetitions)
                         : Copy.ConfigView.indefinitely)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.grayOne)
                    Stepper("", value: $numberOfRepetitions)
                        .opacity(repeatMode == .finite ? 1 : 0)
                }
                .frame(maxWidth: .infinity)
                Text(Copy.ConfigView.times)
                    .opacity(repeatMode == .finite ? 1 : 0)
            }
        }
    }
}

private extension ConfigView {
    /// Workaround to customize the appearance of the segmented picker.
    ///
    /// Short of creating a custom component, there does not seem to be any other way to accomplish this.
    func overrideSegmentedPickerAppearance() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}

struct ConfigView_Previews: PreviewProvider {
    struct ConfigViewPreview: View {
        @State var repeatMode: RepeatMode = .finite
        @State var numberOfRepetitions = 5
        
        var body: some View {
            ConfigView(repeatMode: $repeatMode,
                      numberOfRepetitions: $numberOfRepetitions)
        }
    }
    
    static var previews: some View {
        ConfigViewPreview()
    }
}
