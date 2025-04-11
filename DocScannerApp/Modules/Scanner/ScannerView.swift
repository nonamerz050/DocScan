//
//  ScannerView.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    let scannerService: ScannerServiceProtocol
    let onResult: (Result<VNDocumentCameraScan, Error>) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onResult: onResult)
    }

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let controller = VNDocumentCameraViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}

    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let onResult: (Result<VNDocumentCameraScan, Error>) -> Void

        init(onResult: @escaping (Result<VNDocumentCameraScan, Error>) -> Void) {
            self.onResult = onResult
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            controller.dismiss(animated: true)
            onResult(.success(scan))
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            controller.dismiss(animated: true)
            onResult(.failure(NSError(domain: "UserCancelled", code: 0)))
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            controller.dismiss(animated: true)
            onResult(.failure(error))
        }
    }
}
