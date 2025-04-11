//
//  ScannerServiceProtocol.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import VisionKit

protocol ScannerServiceProtocol {
    func scan(from viewController: UIViewController, completion: @escaping (Result<VNDocumentCameraScan, Error>) -> Void)
}
