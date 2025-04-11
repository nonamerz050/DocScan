//
//  MockScan.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import UIKit
@testable import DocScannerApp

final class MockScan: ScannedDocumentProtocol {
    var pageCount: Int

    init(pageCount: Int) {
        self.pageCount = pageCount
    }

    func imageOfPage(at index: Int) -> UIImage {
        UIImage(systemName: "doc.fill") ?? UIImage()
    }
}
