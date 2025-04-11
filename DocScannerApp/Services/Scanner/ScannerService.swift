//
//  ScannerService.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//


import UIKit
import VisionKit

final class ScannerService: NSObject, ScannerServiceProtocol {
    private var completion: ((Result<VNDocumentCameraScan, Error>) -> Void)?

    func scan(from viewController: UIViewController, completion: @escaping (Result<VNDocumentCameraScan, Error>) -> Void) {
        self.completion = completion
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = self
        viewController.present(scanner, animated: true)
    }
}

extension ScannerService: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true)
        completion?(.success(scan))
    }

    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
        completion?(.failure(NSError(domain: "UserCancelled", code: 0)))
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true)
        completion?(.failure(error))
    }
}