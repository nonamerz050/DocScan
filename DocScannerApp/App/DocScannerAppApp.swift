//
//  DocScannerAppApp.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI
import SwiftData

@main
struct DocumentScannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Document.self)
        }
    }
}
