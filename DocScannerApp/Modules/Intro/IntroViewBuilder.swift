//
//  IntroViewBuilder.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import SwiftUI

struct IntroViewBuilder {
    @MainActor
    static func make(onFinish: @escaping () -> Void) -> some View {
        let viewModel = IntroViewModel(onFinish: onFinish)
        return IntroView(viewModel: viewModel)
    }
}
