# 📄 DocumentScanner

**DocumentScanner** — это iOS-приложение для сканирования и безопасного хранения документов с помощью камеры устройства. Приложение реализовано на SwiftUI и использует VisionKit и SwiftData. Вы можете не только сканировать документы, но и защитить их с помощью **Face ID или Touch ID**.

---

## 🚀 Функциональность

- 📷 Сканирование документов через встроенную камеру (`VisionKit`)
- 🗂 Хранение документов локально с помощью `SwiftData`
- 🔐 **Защита отдельных документов с помощью Face ID / Touch ID**
- 📄 Поддержка нескольких страниц в одном документе
- 🧭 Современная навигация на базе `NavigationStack`
- ✨ Анимации при переходах между экранами
- 🌓 Поддержка тёмной темы

---

## 🔐 Защита документов

- Любой документ может быть заблокирован пользователем
- Доступ к такому документу возможен только после успешной биометрической авторизации через **Face ID или Touch ID**
- Используется `LocalAuthentication.framework`

---

## 🛠 Используемые технологии

- SwiftUI (UI и навигация)
- VisionKit (`VNDocumentCameraViewController`)
- SwiftData (`@Model`, `@Query`)
- LocalAuthentication (Face ID / Touch ID)
- Async/Await (`Task`, `MainActor.run`)
- Анимации через `matchedGeometryEffect` и `.transition`

---

## 📦 Установка

1. Клонируй репозиторий:
```bash
git clone https://github.com/твой-логин/DocumentScanner.git
