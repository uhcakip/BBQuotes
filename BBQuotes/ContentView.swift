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

    var body: some View {
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
        }
        .preferredColorScheme(.dark)
        .enableInjection()
    }
}

#Preview {
    ContentView()
}
