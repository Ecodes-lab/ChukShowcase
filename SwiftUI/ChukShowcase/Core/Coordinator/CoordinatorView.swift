//
//  CoordinatorView.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI

struct CoordinatorView: View {
    @State private var coordinator = Coordinator()
        
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                coordinator.build(page: .showcase)
                .accentColor(ColorManager.accent)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover, content: { fullScreenCover in
                    coordinator.build(fullScreenCover: fullScreenCover)
                })
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
        }
        .environment(coordinator)
    }
}

#Preview {
    CoordinatorView()
}
