//
//  VNTextRecognizerView.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 11/01/2025.
//

import SwiftUI

struct VNTextRecognizerView: View {
    @State private var cameraFeature = CameraFeature()
    
    var body: some View {
        // Your existing showcase view content
        Button("Scan Text") {
            cameraFeature.startScanning()
        }
        .sheet(isPresented: $cameraFeature.isShowingCamera) {
            CameraView { scannedCode in
                // Handle the scanned code
                cameraFeature.scannedCode = scannedCode
            }
        }
    }
}
