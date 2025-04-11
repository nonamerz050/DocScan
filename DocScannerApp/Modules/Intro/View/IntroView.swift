//
//  IntroView.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 11.04.2025.
//

import SwiftUI

struct IntroView: View {
    @StateObject var viewModel: IntroViewModel
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack {
                Spacer(minLength: 0)
                
                MorphingSymbolView(
                    symbol: viewModel.currentPage.rawValue,
                    config: .init(
                        font: .system(size: 150, weight: .bold),
                        frame: .init(width: 250, height: 200),
                        radius: 30,
                        foregroundColor: .blue,
                        keyFrameDuration: 0.4,
                        symbolAnimation: .smooth(duration: 0.5, extraBounce: 0)
                    )
                )
                
                textContents(size: size)
                
                Spacer(minLength: 0)
                
                indicatorView()
                
                continueButton()
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                headerView()
            }
        }
        .background {
            Color(.systemBackground)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func textContents(size: CGSize) -> some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(IntroPage.allCases, id: \.rawValue) { page in
                    Text(page.title)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .kerning(1.1)
                        .frame(width: size.width)
                }
            }
            .offset(x: -viewModel.currentPage.index * size.width)
            .animation(.bouncy(duration: 0.7, extraBounce: 0.0), value: viewModel.currentPage)
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(IntroPage.allCases, id: \.rawValue) { page in
                    Text(page.subtitle)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .frame(width: size.width)
                }
            }
            .offset(x: -viewModel.currentPage.index * size.width)
            .animation(.bouncy(duration: 0.9, extraBounce: 0.0), value: viewModel.currentPage)
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    @ViewBuilder
    func indicatorView() -> some View {
        HStack(spacing: 6) {
            ForEach(IntroPage.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(Color.blue.opacity(viewModel.currentPage == page ? 1 : 0.4))
                    .frame(width: viewModel.currentPage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: viewModel.currentPage)
        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            Button {
                viewModel.goPrevious()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
            }
            .opacity(viewModel.isFirst ? 0 : 1)
            
            Spacer(minLength: 0)
            
            Button("Skip") {
                viewModel.skipToLast()
            }
            .fontWeight(.semibold)
            .opacity(viewModel.isLast ? 0 : 1)
        }
        .foregroundStyle(Color.accentColor)
        .animation(.snappy(duration: 0.35, extraBounce: 0), value: viewModel.currentPage)
        .padding(15)
    }
    
    @ViewBuilder
    func continueButton() -> some View {
        Button {
            viewModel.goNext()
        } label: {
            Text(viewModel.isLast ? "Start Scanning" : "Continue")
                .contentTransition(.identity)
                .foregroundStyle(.white)
                .padding(.vertical, 15)
                .frame(maxWidth: viewModel.currentPage == .lock ? 220 : 180)
                .background(.blue, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: viewModel.currentPage)
    }
}
