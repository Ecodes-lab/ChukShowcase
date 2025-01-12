//
//  CodeBlockView.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI

struct CodeBlockView: View {
    let code: String
    
    // New: Line numbers and syntax highlighting colors
    private let lineNumberWidth: CGFloat = 50
    private let syntaxColors: [String: Color] = [
        "class": .purple,
        "struct": .purple,
        "func": .purple,
        "var": .purple,
        "let": .purple,
        "import": .purple,
        "guard": .purple,
        "if": .purple,
        "else": .purple,
        "return": .purple,
        "private": .purple,
        "do": .purple,
        "try": .purple,
        "catch": .purple,
        
        "String": .teal,
        "Bool": .teal,
        "AVAudioPlayer": .teal,
        "Bundle": .teal,
        
        "\".*\"": .red,  // Strings
        "//.*": .green,  // Comments
        "\\d+": .orange  // Numbers
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                // Line numbers
                VStack(alignment: .trailing) {
                    ForEach(Array(code.components(separatedBy: .newlines).enumerated()), id: \.offset) { index, _ in
                        Text("\(index + 1)")
                            .foregroundStyle(.gray)
                            .font(.system(.body, design: .monospaced))
                            .padding(.horizontal, 8)
                    }
                }
                .frame(width: lineNumberWidth)
                .background(Color(.systemGray6))
                
                // Code content
                VStack(alignment: .leading) {
                    Text(attributedCode)
                        .textSelection(.enabled)
                }
                .padding(.horizontal, 12)
            }
        }
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .font(.system(.body, design: .monospaced))
    }
    
    // Syntax highlighting logic
    private var attributedCode: AttributedString {
        var attributed = AttributedString(code)
        
        // Apply syntax highlighting
        for (pattern, color) in syntaxColors {
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let nsRange = NSRange(code.startIndex..., in: code)
                
                regex.enumerateMatches(in: code, options: [], range: nsRange) { match, _, _ in
                    guard let match = match else { return }
                    
                    if let range = Range(match.range, in: code) {
                        let attributedRange = attributed.range(of: String(code[range]))
                        if let attributedRange = attributedRange {
                            attributed[attributedRange].foregroundColor = color
                        }
                    }
                }
            } catch {
                print("Regex error: \(error)")
            }
        }
        
        return attributed
    }
}

// Preview provider
#Preview {
    CodeBlockView(code: """
    import AVFoundation
    
    class AudioPlayerService {
        private var audioPlayer: AVAudioPlayer?
        var isPlaying = false
        
        // Setup audio player
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
    }
    """)
    .frame(height: 400)
    .padding()
}
