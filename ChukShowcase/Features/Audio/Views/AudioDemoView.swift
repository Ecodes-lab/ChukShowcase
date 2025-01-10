//
//  AudioDemoView.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI

struct AudioDemoView: View {
    @State private var audioService = AudioPlayerService()
    @State private var showingCode = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Audio Player UI
                VStack {
                    Image(systemName: "waveform")
                        .font(.system(size: 100))
                        .foregroundStyle(.blue)
                        .symbolEffect(.bounce, options: .repeating, value: audioService.isPlaying)
                    
                    Button(action: {
                        audioService.togglePlayback()
                    }) {
                        Label(
                            audioService.isPlaying ? "Pause" : "Play",
                            systemImage: audioService.isPlaying ? "pause.circle.fill" : "play.circle.fill"
                        )
                        .font(.title)
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                                
                // Show Code Button
                Button("Show Implementation") {
                    showingCode.toggle()
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .navigationTitle("Audio Framework Demo")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingCode) {
                AudioCodeView()
            }
            .onAppear {
                audioService.setupAudio()
            }
        }
    }
}
