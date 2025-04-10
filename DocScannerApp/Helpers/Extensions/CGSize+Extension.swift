//
//  CGSize+Extension.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//


import SwiftUI

extension CGSize {
    /// This function will return a new size that fits the given size in an aspect ratio
    func aspectFit(_ to: CGSize) -> CGSize {
        let scaleX = to.width / self.width
        let scaleY = to.height / self.height
        
        let aspectRatio = min(scaleX, scaleY)
        return .init(width: aspectRatio * width, height: aspectRatio * height)
    }
}
