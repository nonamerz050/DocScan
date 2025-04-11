# 📄 DocumentScanner

**DocumentScanner** is a modern iOS application for scanning and securely storing multi-page documents using the device camera. Built with SwiftUI and powered by VisionKit and SwiftData.

---

## 🚀 Features

- 📷 Scan documents using the native camera interface (VisionKit)
- 🗂 Store scanned documents locally using SwiftData
- 🔐 Secure documents individually with Face ID / Touch ID
- 📄 Support for multi-page document scanning
- 🧭 Modern navigation with `NavigationStack`
- ✨ Smooth transitions and animations
- 🌓 Full dark mode support

---

## 🔐 Document Protection

- Any document can be locked by the user
- Locked documents require biometric authentication (Face ID / Touch ID)
- Implemented via `LocalAuthentication.framework`

---

## 🧱 Architecture & Tech Stack

- ✅ **SwiftUI** for UI and navigation
- ✅ **VisionKit** (`VNDocumentCameraViewController`) for document scanning
- ✅ **SwiftData** for local storage (`@Model`, `@Query`)
- ✅ **Async/Await** with structured concurrency (`Task`, `MainActor.run`)
- ✅ **LocalAuthentication** for biometric protection
- ✅ **Dependency Injection** using a centralized `DIContainer`
- ✅ Modular structure: `Home`, `Scanner`, `Document`, `Services`
- ✅ Clean MVVM architecture with clear separation of responsibilities

---

## 🧪 Unit Testing

The project includes modern, focused unit tests:

- ✅ Verifies successful document saving flow
- ✅ Tests error handling without clearing ViewModel state
- ✅ Uses mock services (`MockDocumentStorageService`, `MockScan`)
- ✅ All async logic tested with proper `MainActor` isolation

To run the tests:
```bash
Cmd + U
# or via Product > Test
```

## 📦  Installation
```bash
git clone https://github.com/твой-логин/DocumentScanner.git
```
