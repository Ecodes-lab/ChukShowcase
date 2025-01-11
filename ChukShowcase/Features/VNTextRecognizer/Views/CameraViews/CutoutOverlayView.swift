//
//  CutoutOverlayView.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 11/01/2025.
//

import SwiftUI

/// A view that creates a semi-transparent overlay with a cutout area for scanning
struct CutoutOverlayView: View {
    // MARK: - Properties
    private var overlayColor = Color.black.opacity(0.5)
    private var cutoutHeight: CGFloat = 100  // Adjust as needed
    private var cutoutWidth: CGFloat = 300   // Adjust as needed
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let rect = CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height)
            let cutoutRect = CGRect(
                x: (geometry.size.width - cutoutWidth) / 2,
                y: (geometry.size.height - cutoutHeight) / 2,
                width: cutoutWidth,
                height: cutoutHeight
            )
            
            CutoutShape(rect: rect, cutout: cutoutRect)
                .fill(overlayColor)
                .ignoresSafeArea()
            
            // Optional: Add scanning area border
            Rectangle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: cutoutWidth, height: cutoutHeight)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            // Optional: Add scanning guidelines
            Rectangle()
                .fill(Color.white)
                .frame(width: 40, height: 2)
                .position(x: (geometry.size.width - cutoutWidth) / 2 - 20,
                         y: geometry.size.height / 2)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 40, height: 2)
                .position(x: (geometry.size.width + cutoutWidth) / 2 + 20,
                         y: geometry.size.height / 2)
        }
    }
}

/// A shape that creates a rectangle with a cutout
struct CutoutShape: Shape {
    let rect: CGRect
    let cutout: CGRect
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Add the outer rectangle
        path.addRect(self.rect)
        
        // Subtract the inner rectangle (cutout)
        path.addRect(cutout)
        
        // Use .evenOdd fill rule to create the cutout effect
//            .init(from: .init(eoFill: true))
        return path.applying(.init())
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.blue // Background to simulate camera view
        CutoutOverlayView()
    }
}

// MARK: - Additional Customization Options
extension CutoutOverlayView {
    /// Creates an animated scanning line effect
    private var scanningLine: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .white.opacity(0.8), .clear]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: 2, height: cutoutHeight)
            .offset(x: 0, y: -cutoutHeight/2)
            .modifier(ScanningAnimationModifier())
    }
}

/// Modifier to create scanning animation
struct ScanningAnimationModifier: ViewModifier {
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .offset(x: isAnimating ? 150 : -150)
            .animation(
                Animation.linear(duration: 2.0)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

// MARK: - Additional Configuration Options
extension CutoutOverlayView {
    /// Configuration options for the cutout overlay
    struct Configuration {
        var overlayColor: Color = .black.opacity(0.5)
        var cutoutHeight: CGFloat = 100
        var cutoutWidth: CGFloat = 300
        var borderColor: Color = .white
        var borderWidth: CGFloat = 2
        var showScanningLine: Bool = true
        var showGuidelines: Bool = true
        
        static let `default` = Configuration()
    }
    
    /// Initialize with custom configuration
    init(configuration: Configuration = .default) {
        self.overlayColor = configuration.overlayColor
        self.cutoutHeight = configuration.cutoutHeight
        self.cutoutWidth = configuration.cutoutWidth
    }
}
