//
//  CameraSession.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 11/01/2025.
//

import AVFoundation
import Vision

@Observable
class CameraSession: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    // MARK: - Properties
    var session = AVCaptureSession()
    var scannedCode: String?
    
    private let videoOutput = AVCaptureVideoDataOutput()
    private let stringTracker = StringTracker()
    
    // MARK: - Session management
    func startSession() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                await setupSession()
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    await setupSession()
                }
            default:
                break
            }
        }
    }
    
    func stopSession() {
        guard session.isRunning else { return }
        session.stopRunning()
    }
    
    func restartScanning() {
        scannedCode = nil
        if !session.isRunning {
            session.startRunning()
        }
    }
    
    // MARK: - Private methods
    private func setupSession() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "com.camera.videoOutput"))
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        session.startRunning()
    }
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let results = request.results as? [VNRecognizedTextObservation] else { return }
            
            let recognizedStrings = results.compactMap { observation -> String? in
                guard let candidate = observation.topCandidates(1).first else { return nil }
                return candidate.string.extractText()?.1
            }
            
            self?.stringTracker.logFrame(strings: recognizedStrings)
            if let stableString = self?.stringTracker.getStableString() {
                DispatchQueue.main.async {
                    self?.scannedCode = stableString
                    self?.session.stopRunning()
                }
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            .perform([request])
    }
}
