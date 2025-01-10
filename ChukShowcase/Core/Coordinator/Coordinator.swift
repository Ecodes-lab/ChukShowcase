//
//  Coordinator.swift
//  AppleFrameShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI
import Observation

enum Page: Hashable {
    case showcase
}

enum Sheet: Hashable, Identifiable {
    case calendar, audio
    
    var id: Int {
        self.hashValue
    }
}

enum Modal: String, Identifiable {
    case view
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case view
    
    var id: String {
        self.rawValue
    }
}

enum HomeTab {
    case view
}

@Observable class Coordinator {
    var path = NavigationPath()
    var sheet: Sheet?
    var modal: Modal?
    var fullScreenCover: FullScreenCover?
    var tab: HomeTab = .view
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(modal: Modal) {
        self.modal = modal
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissModal() {
        self.modal = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .showcase:
            ShowcaseView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .calendar:
            CalendarView()
        case .audio:
            AudioDemoView()
        }
    }
    
    @ViewBuilder
    func build(modal: Modal) -> some View {
        switch modal {
        case .view:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .view:
            EmptyView()
        }
    }
}
