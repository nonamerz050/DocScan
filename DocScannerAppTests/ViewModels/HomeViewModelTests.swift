//
//  HomeViewModelTests.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import XCTest
@testable import DocScannerApp

final class HomeViewModelTests: XCTestCase {
    func testCreateDocumentSuccessfullyCallsStorageService() async {

        let storageService = MockDocumentStorageService()
        let viewModel = await HomeViewModel(storageService: storageService)

        let mockScan = MockScan(pageCount: 2)

        await MainActor.run {
            viewModel.scanDocument = mockScan
            viewModel.documentName = "Test Document"
        }

        await viewModel.createDocument()

        XCTAssertTrue(storageService.didCallSave)
        XCTAssertEqual(storageService.savedName, "Test Document")
        XCTAssertEqual(storageService.savedScan?.pageCount, 2)
    }
    
    func testCreateDocument_whenSaveFails_shouldNotClearStateAndSetIsLoadingFalse() async {
        let storageService = MockDocumentStorageService()
        storageService.shouldThrow = true

        let viewModel = await HomeViewModel(storageService: storageService)
        let mockScan = MockScan(pageCount: 1)

        await MainActor.run {
            viewModel.scanDocument = mockScan
            viewModel.documentName = "Test Error"
        }

        await viewModel.createDocument()

        await MainActor.run {
            XCTAssertTrue(storageService.didCallSave)
            XCTAssertEqual(viewModel.scanDocument?.pageCount, 1)
            XCTAssertEqual(viewModel.documentName, "Test Error")
            XCTAssertFalse(viewModel.isLoading)
        }
    }
}
