//
//  HomeViewBuilder.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI
import SwiftData

@MainActor
struct HomeViewBuilder {
    static func make() -> some View {
        let viewModel = HomeViewModel(
            storageService: DIContainer.shared.documentStorageService
        )
        return HomeView(viewModel: viewModel)
    }
}
