//
//  ContentView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/13.
//

import Inject
import SwiftUI

struct ContentView: View {
    @ObserveInjection var injection
    @Environment(\.geometrySize) var size

    var body: some View {
        GeometryReader { geo in
            TabView {
                QuoteView(production: .breakingBad)
                    .toolbarBackground(.visible, for: .tabBar)
                    .tabItem {
                        Label("Breaking Bad", systemImage: "tortoise")
                    }

                QuoteView(production: .betterCallSaul)
                    .toolbarBackground(.visible, for: .tabBar)
                    .tabItem {
                        Label("Better Call Saul", systemImage: "briefcase")
                    }

                QuoteView(production: .elCamino)
                    .toolbarBackground(.visible, for: .tabBar)
                    .tabItem {
                        Label("El Camino", systemImage: "car")
                    }
            }
            .environment(\.geometrySize, geo.size)
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .enableInjection()
    }
}

#Preview {
    ContentView()
}
