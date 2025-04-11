//
//  ScannedDocumentProtocol.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import UIKit

protocol ScannedDocumentProtocol {
    var pageCount: Int { get }
    func imageOfPage(at index: Int) -> UIImage
}
