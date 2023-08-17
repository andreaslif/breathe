//
//  Color+.swift
//  Breathe
//
//  Created by Andreas Lif on 2023-08-17.
//

import Foundation
import SwiftUI

public extension Color {
    static let backgroundOne = Color(dark: .init(hex: "202024"), light: .init(hex: "E0E0E8"))
    static let accentOne = Color(dark: .init(hex: "EB477B"), light: .init(hex: "EB477B"))
    static let grayOne = Color(dark: .init(hex: "BEBEC2"), light: .init(hex: "5E5E62"))
    static let blackWhite = Color(dark: .init(hex: "FFFFFF"), light: .init(hex: "000000"))
    
    init(dark: Color, light: Color) {
        self.init(uiColor: .init(dynamicProvider: { traits in
            if traits.userInterfaceStyle == .dark {
                return .init(dark)
            } else {
                return .init(light)
            }
        }))
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
