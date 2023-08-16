//
//  CircularPatternView.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-16.
//

import SwiftUI

struct CircularPatternView: View {
    let totalSteps: Int
    let size: Double
    
    var numberOfStepsToShow: Binding<Int>
    
    var angleIncrement: Double { Double(360 / totalSteps) }
    
    var body: some View {
        ZStack {
            Group {
                ForEach(0...totalSteps - 1, id: \.self) { index in
                    VStack(spacing: .zero) {
                        Circle()
                            .frame(maxWidth: 20)
                            .opacity(index < numberOfStepsToShow.wrappedValue ? 0.1 : 0)
                        Spacer()
                    }
                    .frame(maxHeight: size)
                    .rotationEffect(Angle(degrees: angleIncrement * Double(index)))
                }
            }
            .frame(maxWidth: size, maxHeight: size)
        }
        
    }
}


struct CircularPatternView_Previews: PreviewProvider {
    static var previews: some View {
        CircularPatternView(totalSteps: 5, size: 300, numberOfStepsToShow: .constant(2))
    }
}
