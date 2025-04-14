//
//  IconView.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 14.04.2025.
//

import SwiftUI

// MARK: - Pack IconView
struct IconView: View {
    let name: IconName
    var fontSize: CGFloat = 16
    var weight: Font.Weight = .regular
    var color: Color?
    var secondColor: Color?
    var mode: SymbolRenderingMode = .monochrome

    var body: some View {
        if let color {
            image.foregroundStyle(color, secondColor ?? .clear)
        } else {
            image
        }
    }
}

// MARK: - Build method
private extension IconView {
    var image: some View {
        let image = name.type == .system ? Image(systemName: name.rawValue) : Image(name.rawValue)
        return image
            .font(.system(size: fontSize, weight: weight))
            .symbolRenderingMode(mode)
    }
}

enum IconName: String {
    case squareArrowUpFill = "square.and.arrow.up.fill"
    case lockFill = "lock.fill"
    case lockOpenFill = "lock.open.fill"
    case trashFill = "trash.fill"
    
    var type: IconType {
        switch self {
        default: .system
        }
    }
}

// MARK: - Icon Type
enum IconType {
    case customIcon
    case system
}
