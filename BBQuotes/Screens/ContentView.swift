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
            QuoteEpisodeView(production: .breakingBad)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Production.breakingBad.rawValue, systemImage: "tortoise")
                }

            QuoteEpisodeView(production: .betterCallSaul)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Production.betterCallSaul.rawValue, systemImage: "briefcase")
                }

            QuoteEpisodeView(production: .elCamino)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Production.elCamino.rawValue, systemImage: "car")
                }
        }
        .preferredColorScheme(.dark)
        .enableInjection()
    }
}

#Preview {
    ContentView()
}
