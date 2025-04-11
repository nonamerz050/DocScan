//
//  ContentView.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @AppStorage("showIntroView") private var hasSeenIntro: Bool = false
    @AppStorage("showWhatsNew") private var showWhatsNew: Bool = false
    
    var body: some View {
        if hasSeenIntro {
            HomeViewBuilder.make()
                .sheet(isPresented: $showWhatsNew) {
                    WhatsNewScreen()
                        .interactiveDismissDisabled()
                }
        } else {
            IntroViewBuilder.make {
                hasSeenIntro = true
            }
        }
    }
}

#Preview {
    ContentView()
}
