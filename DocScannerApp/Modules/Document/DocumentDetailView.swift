//
//  DocumentDetailView.swift
//  DocScannerApp
//
//  Created by Artem Kolesnik on 10.04.2025.
//


import SwiftUI
import PDFKit
import LocalAuthentication

struct DocumentDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var scene
    
    @State private var isLoading: Bool = false
    @State private var showFileMover: Bool = false
    @State private var fileURL: URL?

    @State private var isLockAvailable: Bool?
    @State private var isUnlocked: Bool = false
    
    var document: Document

    var body: some View {
        if let pages = document.pages?.sorted(by: { $0.pageIndex < $1.pageIndex }) {
            VStack(spacing: 10) {
                headerView()
                    .padding([.horizontal, .top], 15)
                
                TabView {
                    ForEach(pages) { page in
                        if let image = UIImage(data: page.pageData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .tabViewStyle(.page)
            }
            .background(.black)
            .toolbarVisibility(.hidden, for: .navigationBar)
            .loadingScreen(status: $isLoading)
            .overlay {
                lockView()
            }
            .fileMover(isPresented: $showFileMover, file: fileURL) { result in
                if case .failure(_) = result {
                    /// Removing the temporary file
                    guard let fileURL else { return }
                    try? FileManager.default.removeItem(at: fileURL)
                    self.fileURL = nil
                }
            }
            .onAppear {
                guard document.isLocked else {
                    isUnlocked = true
                    return
                }
                
                let context = LAContext()
                isLockAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            }
            .onChange(of: scene) { oldValue, newValue in
                if newValue != .active && document.isLocked {
                    isUnlocked = false
                }
            }
        }
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        Text(document.name)
            .font(.system(size: 20))
            .foregroundStyle(.white)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 65)
            .overlay {
                HStack(spacing: 15) {
                    Button {
                        document.isLocked.toggle()
                        isUnlocked = !document.isLocked
                        try? context.save()
                    } label: {
                        IconView(name: document.isLocked ? .lockFill : .lockOpenFill,
                                 fontSize: 22,
                                 color: .blue)
                    }
                    
                    Button {
                        createAndShareDocument()
                    } label: {
                        IconView(name: .squareArrowUpFill,
                                 fontSize: 20,
                                 color: .blue)
                    }

                    Spacer()
                    
                    Button {
                        dismiss()
                        Task { @MainActor in
                            try? await Task.sleep(for: .seconds(0.3))
                            context.delete(document)
                            try? context.save()
                        }
                    } label: {
                        IconView(name: .trashFill,
                                 fontSize: 20,
                                 color: .red)
                    }
                }
            }
    }
    
    @ViewBuilder
    private func lockView() -> some View {
        if document.isLocked {
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack(spacing: 6) {
                    if let isLockAvailable, !isLockAvailable {
                        Text("Please enable biometric access in Settings to unlock this document!")
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    } else {
                        Image(systemName: "lock.fill")
                            .font(.largeTitle)
                        
                        Text("Tap to unlock!")
                            .font(.callout)
                    }
                }
                .onTapGesture(perform: authenticateUser)
            }
            .opacity(isUnlocked ? 0 : 1)
            .animation(snappy, value: isUnlocked)
        }
    }
    
    private func authenticateUser() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Locked Document") { status, _ in
                DispatchQueue.main.async {
                    self.isUnlocked = status
                }
            }
        } else {
            isLockAvailable = false
            isUnlocked = false
        }
    }
    
    private func createAndShareDocument() {
        /// Converting SwiftData document into a PDF Document
        guard let pages = document.pages?.sorted(by: { $0.pageIndex < $1.pageIndex }) else { return }
        isLoading = true
        
        Task.detached(priority: .high) { [document] in
            try? await Task.sleep(for: .seconds(0.2))
            
            let pdfDocument = PDFDocument()
            for index in pages.indices {
                if let pageImage = UIImage(data: pages[index].pageData),
                   let pdfPage = PDFPage(image: pageImage) {
                    pdfDocument.insert(pdfPage, at: index)
                }
            }
                    
            var pdfURL = FileManager.default.temporaryDirectory
            let fileName = "\(document.name).pdf"
            pdfURL.append(path: fileName)
                    
            if pdfDocument.write(to: pdfURL) {
                await MainActor.run { [pdfURL] in
                    fileURL = pdfURL
                    showFileMover = true
                    isLoading = false
                }
            }
        }
    }
}
