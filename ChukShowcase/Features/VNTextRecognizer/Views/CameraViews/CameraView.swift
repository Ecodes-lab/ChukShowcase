//
//  CameraView.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 11/01/2025.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @State private var cameraSession = CameraSession()
    @Environment(\.dismiss) private var dismiss
    
    var onCodeScanned: (String) -> Void
    
    var body: some View {
        ZStack {
            // Camera preview
            CameraPreviewView(session: cameraSession.session)
                .ignoresSafeArea()
            
            // Overlay
            VStack {
                // Cutout overlay with custom configuration
                CutoutOverlayView(configuration: .init(
                    cutoutHeight: 20,
                    cutoutWidth: 280,
                    showScanningLine: true
                ))
                
                Spacer()
                
                // Scanned code display
                if let code = cameraSession.scannedCode {
                    Text(code)
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                }
                
                // Control buttons
                HStack(spacing: 70) {
                    Button("Close") {
                        dismiss()
                    }
                    
                    Button {
                        cameraSession.restartScanning()
                    } label: {
                        Image(systemName: "repeat")
                            .font(.system(size: 50))
                    }
                    
                    Button {
                        if let code = cameraSession.scannedCode {
                            onCodeScanned(code)
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 25))
                    }
                    .disabled(cameraSession.scannedCode == nil)
                    .opacity(cameraSession.scannedCode == nil ? 0.5 : 1)
                }
                .foregroundColor(.white)
                .padding(.bottom)
            }
        }
        .onAppear {
            cameraSession.startSession()
        }
        .onDisappear {
            cameraSession.stopSession()
        }
    }
}
