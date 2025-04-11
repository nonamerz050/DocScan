//
//  IntroViewModel.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import SwiftUI

@MainActor
final class IntroViewModel: ObservableObject {
    @Published var currentPage: IntroPage = .scan
    
    let onFinish: () -> Void

    init(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
    }

    func goNext() {
        if currentPage == .lock {
            onFinish()
        } else {
            currentPage = currentPage.next
        }
    }
    
    func skipToLast() {
        currentPage = .lock
    }

    func goPrevious() {
        currentPage = currentPage.previous
    }

    var isFirst: Bool { currentPage == .scan }
    var isLast: Bool { currentPage == .lock }
}
