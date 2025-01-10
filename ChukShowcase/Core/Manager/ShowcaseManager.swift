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
    let demoView: AnyView? // New property for the demo view
    let coverType: Sheet
    
    init(name: String,
         description: String,
         imageName: String,
         demoView: AnyView? = nil,
         coverType: Sheet
    ) {
        self.name = name
        self.description = description
        self.imageName = imageName
        self.demoView = demoView
        self.coverType = coverType
    }
}

@Observable
class ShowcaseManager {
    var showcaseList: [Showcase] = [
        Showcase(
            name: "AVFoundation",
            description: "Work with audiovisual assets, control device cameras, process audio, and configure system audio interactions.",
            imageName: "waveform",
            demoView: AnyView(AudioDemoView()),
            coverType: .audio
        )
    ]
}
