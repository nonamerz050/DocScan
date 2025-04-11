//
//  DIContainer.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//


import SwiftData

final class DIContainer {
    static let shared = DIContainer()
    
    // MARK: - Services
    let documentStorageService: DocumentStorageServiceProtocol
    let scannerService: ScannerServiceProtocol

    private init() {
        let context = DIContainer.resolveModelContext()
        self.documentStorageService = DocumentStorageService(context: context)
        self.scannerService = ScannerService()
    }

    private static func resolveModelContext() -> ModelContext {
        let container = try! ModelContainer(for: Document.self, DocumentPage.self)
        return ModelContext(container)
    }
}
