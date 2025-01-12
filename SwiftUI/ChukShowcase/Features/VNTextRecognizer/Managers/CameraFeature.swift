//
//  CameraFeature.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 11/01/2025.
//

import SwiftUI

/// A feature module that handles camera functionality for scanning texts
@Observable
public class CameraFeature {
    // MARK: - Public properties
    public var isShowingCamera = false
    public var scannedCode: String?
    public var capturedImage: UIImage?
    
    public init() {}
    
    // MARK: - Public methods
    public func startScanning() {
        isShowingCamera = true
    }
    
    public func stopScanning() {
        isShowingCamera = false
    }
}
