//
//  IntroPage.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import SwiftUI

enum IntroPage: String, CaseIterable {
    case scan = "doc.viewfinder.fill"
    case pdf = "doc.richtext.fill"
    case faceID = "touchid"
    case lock = "lock.doc.fill"

    var title: String {
        switch self {
        case .scan: return "Scan Documents"
        case .pdf: return "Save as PDF"
        case .faceID: return "Biometric Security"
        case .lock: return "Private Document Vault"
        }
    }

    var subtitle: String {
        switch self {
        case .scan: return "Quickly capture documents using your\ndevice’s camera"
        case .pdf: return "Store scanned pages as clean,\nshareable PDF files"
        case .faceID: return "Lock access using Face ID or Touch ID"
        case .lock: return "Keep sensitive files safe and encrypted locally"
        }
    }

    var index: CGFloat {
        CGFloat(Int(Self.allCases.firstIndex(of: self) ?? 0))
    }

    var next: IntroPage {
        let nextIndex = Int(index) + 1
        return nextIndex < Self.allCases.count ? Self.allCases[nextIndex] : self
    }

    var previous: IntroPage {
        let prevIndex = Int(index) - 1
        return prevIndex >= 0 ? Self.allCases[prevIndex] : self
    }
}
