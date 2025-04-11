//
//  DocumentStorageService.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import Foundation
import SwiftData
import VisionKit

final class DocumentStorageService: DocumentStorageServiceProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func save(scan: ScannedDocumentProtocol, name: String) async throws {
        let document = Document(name: name)
        var pages: [DocumentPage] = []

        for index in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: index)
            guard let data = image.jpegData(compressionQuality: 0.65) else { continue }
            let page = DocumentPage(document: document, pageIndex: index, pageData: data)
            pages.append(page)
        }

        document.pages = pages

        try await MainActor.run {
            context.insert(document)
            try context.save()
        }
    }

//    func save(scan: VNDocumentCameraScan, name: String) async throws {
//        let document = Document(name: name)
//        var pages: [DocumentPage] = []
//
//        for pageIndex in 0..<scan.pageCount {
//            let pageImage = scan.imageOfPage(at: pageIndex)
//            guard let pageData = pageImage.jpegData(compressionQuality: 0.65) else { continue }
//            let page = DocumentPage(document: document, pageIndex: pageIndex, pageData: pageData)
//            pages.append(page)
//        }
//
//        document.pages = pages
//
//        try await MainActor.run {
//            context.insert(document)
//            try context.save()
//        }
//    }
}
