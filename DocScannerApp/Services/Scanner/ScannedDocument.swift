//
//  ScannedDocument.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import VisionKit
import UIKit

final class ScannedDocument: ScannedDocumentProtocol {
    private let scan: VNDocumentCameraScan

    init(scan: VNDocumentCameraScan) {
        self.scan = scan
    }

    var pageCount: Int {
        scan.pageCount
    }

    func imageOfPage(at index: Int) -> UIImage {
        scan.imageOfPage(at: index)
    }
}
