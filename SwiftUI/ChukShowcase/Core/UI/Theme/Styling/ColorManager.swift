//
//  ColorManager.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI

struct ColorManager {
    
    static let bg = Color("BackgroundColor")
    static let primary = Color("PrimaryColor")
    static let secondary = Color("SecondaryColor")
    static let accentGradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color("AccentColor"),
                Color("Accent2Color")
            ]
        ),
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )
    static let accent = Color("Accent2Color")
    static let orange = Color("OrangeColor")

    static let text = Color("TextColor")
    static let input = Color("InputColor")
    static let tabBar = Color("BackgroundColor")
}
