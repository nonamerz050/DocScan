//
//  ContentView.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showIntroView") private var showIntroView: Bool = true
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HomeViewBuilder.make()
            .sheet(isPresented: $showIntroView) {
                IntroScreen()
                    .interactiveDismissDisabled()
            }
    }
}

#Preview {
    ContentView()
}
