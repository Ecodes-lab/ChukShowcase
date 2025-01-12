//
//  ShowcaseView.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 09/01/2025.
//

import SwiftUI

struct ShowcaseView: View {
    @Environment(Coordinator.self) var coordinator
    @State private var viewManager = ShowcaseManager()
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewManager.showcaseList) { showcase in
                        ShowcaseItemView(showcase: showcase)
                            .onTapGesture {
                                coordinator.present(sheet: showcase.coverType)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Showcase")
        }
    }
}

struct ShowcaseItemView: View {
    let showcase: Showcase
    
    var body: some View {
        VStack {
            Image(showcase.imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(showcase.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ShowcaseView()
}
