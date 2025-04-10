//
//  DocumentPage.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI
import SwiftData

@Model
class DocumentPage {
    var document: Document?
    var pageIndex: Int
    /// Since it holds image data of each document page
    @Attribute(.externalStorage)
    var pageData: Data
    
    init(document: Document? = nil, pageIndex: Int, pageData: Data) {
        self.document = document
        self.pageIndex = pageIndex
        self.pageData = pageData
    }
}
