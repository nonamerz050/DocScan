//
//  ContentView.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showIntroView") private var showIntroView: Bool = true
    var body: some View {
        Home()
            .sheet(isPresented: $showIntroView) {
                IntroScreen()
                    .interactiveDismissDisabled()
            }
    }
}

#Preview {
    ContentView()
}
