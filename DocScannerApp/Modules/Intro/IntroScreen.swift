//
//  IntroScreen.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//

import SwiftUI

struct IntroScreen: View {
    @AppStorage("showIntroView") private var showIntroView: Bool = true
    
    var body: some View {
        VStack(spacing: 15) {
            Text("What's New in\nDocument Scanner")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
            
            /// Points
            VStack(alignment: .leading, spacing: 25) {
                pointView(
                    title: "Scan Documents",
                    image: "scanner",
                    description: "Scan any document with ease."
                )
                pointView(
                    title: "Save Documents",
                    image: "tray.full.fill",
                    description: "Persist scanned documents with the new SwiftData Model."
                )
                pointView(
                    title: "Lock Documents",
                    image: "faceid",
                    description: "Protect your documents so that only you can Unlock them using FaceID."
                )
            }
            .padding(.horizontal, 25)
            
            Spacer(minLength: 0)
            
            button
        }
        .padding(15)
    }
}

extension IntroScreen {
    @ViewBuilder
    private func pointView(title: String, image: String, description: String, color: Color = .blue) -> some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundStyle(color)
                .frame(width: 35)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    var button: some View {
        Button {
            showIntroView = false
        } label: {
            Text("Start using Document Scanner")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
                .background(.blue.gradient, in: .rect(cornerRadius: 10))
        }
    }
}

#Preview {
    IntroScreen()
}
