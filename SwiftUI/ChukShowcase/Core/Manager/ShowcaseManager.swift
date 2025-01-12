//
//  ShowcaseManager.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI

struct Showcase: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
    let coverType: Sheet
    
    init(name: String,
         description: String,
         imageName: String,
         coverType: Sheet
    ) {
        self.name = name
        self.description = description
        self.imageName = imageName
        self.coverType = coverType
    }
}

@Observable
class ShowcaseManager {
    var showcaseList: [Showcase] = [
        Showcase(
            name: "Calendar",
            description: "",
            imageName: "waveform",
            coverType: .calendar
        ),
        Showcase(
            name: "Audio",
            description: "",
            imageName: "waveform",
            coverType: .audio
        ),
        Showcase(
            name: "Text Recognizer",
            description: "",
            imageName: "waveform",
            coverType: .vnTextRecognizer
        ),
    ]
}
