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
            description: "Work with audiovisual assets, control device cameras, process audio, and configure system audio interactions.",
            imageName: "waveform",
            coverType: .calendar
        ),
        Showcase(
            name: "Audio",
            description: "Work with audiovisual assets, control device cameras, process audio, and configure system audio interactions.",
            imageName: "waveform",
            coverType: .audio
        ),
    ]
}
