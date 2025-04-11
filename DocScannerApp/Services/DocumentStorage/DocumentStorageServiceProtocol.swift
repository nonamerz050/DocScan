//
//  DocumentStorageServiceProtocol.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import VisionKit

protocol DocumentStorageServiceProtocol {
    func save(scan: ScannedDocumentProtocol, name: String) async throws
}
