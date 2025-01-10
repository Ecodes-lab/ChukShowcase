//
//  AudioPlayerService.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI
import AVFoundation

@Observable
final class AudioPlayerService {
    private var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    
    /// Prepares and manages audio playback using AVFoundation
    ///
    /// - Note: This service handles the initialization and control of AVAudioPlayer,
    ///   providing basic audio playback functionality
    
    func setupAudio() {
        guard let url = Bundle.main.url(forResource: "sampleAudio", withExtension: "mp3") else {
            print("Audio file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error setting up audio player: \(error.localizedDescription)")
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
