//
//  HomeViewModel.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import Foundation
import SwiftUI
import SwiftData
import VisionKit

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Published state
    @Published var showScannerView = false
    @Published var scanDocument: ScannedDocumentProtocol?
    @Published var documentName: String = "New Document"
    @Published var askDocumentName = false
    @Published var isLoading = false

    private let storageService: DocumentStorageServiceProtocol

    init(storageService: DocumentStorageServiceProtocol) {
        self.storageService = storageService
    }

    func handleScanFinished(_ scan: VNDocumentCameraScan) {
        scanDocument = ScannedDocument(scan: scan)
        showScannerView = false
        askDocumentName = true
    }

    func handleScanCancelled() {
        self.showScannerView = false
    }

    func handleScanFailed(_ error: Error) {
        self.showScannerView = false
    }
    
    @MainActor
    func createDocument() async {
        guard let scanDocument else { return }

        isLoading = true

        do {
            try await storageService.save(scan: scanDocument, name: documentName)

            self.scanDocument = nil
            documentName = "New Document"
            isLoading = false
        } catch {
            isLoading = false
        }
    }
    
//    func createDocument() {
//        guard let scanDocument else { return }
//        try await storageService.save(scan: scanDocument, name: documentName)
//        isLoading = true
//
//        Task {
//            do {
//                try await storageService.save(scan: scanDocument, name: documentName)
//
//                await MainActor.run {
//                    self.scanDocument = nil
//                    self.documentName = "New Document"
//                    self.isLoading = false
//                }
//
//            } catch {
//                await MainActor.run {
//                    self.isLoading = false
//                }
//            }
//        }
//    }
    
    func finishScan(scan: VNDocumentCameraScan) {
        scanDocument = ScannedDocument(scan: scan)
        showScannerView = false
        askDocumentName = true
    }
    
    func closeScanner() {
        showScannerView = false
    }
}
