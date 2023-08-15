//
//  View+.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-15.
//

import SwiftUI

public extension View {
    func fullScreenBackground(color: Color) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .edgesIgnoringSafeArea(.all)
    }
}
