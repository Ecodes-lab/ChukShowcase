//
//  AudioCodeView.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI

struct AudioCodeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    implementationSection
                    usageSection
                }
                .padding()
            }
            .navigationTitle("Implementation")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var implementationSection: some View {
        VStack(alignment: .leading) {
            Text("Service Implementation")
                .font(.headline)
            
            CodeBlockView(code: """
            import AVFoundation

            class AudioPlayerService {
                private var audioPlayer: AVAudioPlayer?
                var isPlaying = false
                
                func setupAudio() {
                    guard let url = Bundle.main.url(
                        forResource: "sampleAudio",
                        withExtension: "mp3"
                    ) else { return }
                    
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayer?.prepareToPlay()
                    } catch {
                        print("Error: \\(error)")
                    }
                }
                
                func togglePlayback() {
                    if isPlaying {
                        audioPlayer?.pause()
                    } else {
                        audioPlayer?.play()
                    }
                    isPlaying.toggle()
                }
            }
            """)
        }
    }
    
    private var usageSection: some View {
        VStack(alignment: .leading) {
            Text("Usage in SwiftUI")
                .font(.headline)
            
            CodeBlockView(code: """
            struct AudioPlayerView: View {
                @State private var audioService = AudioPlayerService()
                
                var body: some View {
                    Button(action: {
                        audioService.togglePlayback()
                    }) {
                        Label(
                            audioService.isPlaying ? "Pause" : "Play",
                            systemImage: audioService.isPlaying ? 
                                "pause.circle.fill" : 
                                "play.circle.fill"
                        )
                    }
                    .onAppear {
                        audioService.setupAudio()
                    }
                }
            }
            """)
        }
    }
}
