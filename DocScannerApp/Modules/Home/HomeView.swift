//
//  Home.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//


import SwiftUI
import SwiftData
import VisionKit

struct HomeView: View {    
    @StateObject private var viewModel: HomeViewModel
    
    @Namespace private var animationID
    
    @Query(sort: [.init(\Document.createdAt, order: .reverse)], animation: .smooth) private var documents: [Document]
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 15) {
                    ForEach(documents) { document in
                        NavigationLink {
                            DocumentDetailView(document: document)
                                .navigationTransition(.zoom(sourceID: document.uniqueViewID, in: animationID))
                        } label: {
                            DocumentCardView(document: document, animationID: animationID)
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
                .padding(15)
            }
            .navigationTitle("Private Documents")
            .safeAreaInset(edge: .bottom) {
                сreateButton()
            }
        }
        .fullScreenCover(isPresented: $viewModel.showScannerView) {
            ScannerView(scannerService: DIContainer.shared.scannerService) { result in
                switch result {
                case .success(let scan):
                    viewModel.handleScanFinished(scan)
                case .failure:
                    viewModel.handleScanCancelled()
                }
            }
            .ignoresSafeArea()
        }
        .alert("Document Name", isPresented: $viewModel.askDocumentName) {
            TextField("New Document", text: $viewModel.documentName)
            
            Button("Save") {
                viewModel.createDocument()
            }
            .disabled(viewModel.documentName.isEmpty)
        }
        .loadingScreen(status: $viewModel.isLoading)
    }
    
    @ViewBuilder
    private func сreateButton() -> some View {
        Button {
            viewModel.showScannerView.toggle()
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "document.viewfinder.fill")
                    .font(.title3)
                
                Text("Scan Documents")
            }
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(.purple.gradient, in: .capsule)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 10)
        /// Bottom background shade effect 
        .background {
            Rectangle()
                .fill(.background)
                .mask {
                    Rectangle()
                        .fill(.linearGradient(colors: [
                            .white.opacity(0),
                            .white.opacity(0.5),
                            .white.opacity(0.7),
                            .white
                        ], startPoint: .top, endPoint: .bottom))
                }
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
