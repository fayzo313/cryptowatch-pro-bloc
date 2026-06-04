# CryptoWatch Pro — Clean Architecture Sandbox (BLoC)

A high-performance Cross-Platform Market Monitor showcasing senior-level Flutter code structure, production-ready state synchronization, and strict feature separation.

## 🚀 Key Architectural Pillars Illustrated
* **Feature-First Domain Isolation:** Separates data models from core enterprise business rules (`entities`). The domain layer contains zero dependencies on external modules (`Dio`, `SharedPreferences`).
* **Optimized Rendering Handshakes:** Employs explicit bounding properties (`itemExtent`) inside view structures to accelerate size recalculations and enforce zero dropped frames during lists scrolling.
* **Offline-First Resilience:** Employs local persistence interceptors. The UI loads instant local caches seamlessly before spawning background HTTP fetch triggers.

## 📦 Tech Stack & Core Libraries
* **State Management:** Flutter BLoC (with strict Equatable value comparisons)
* **Network Handler:** Dio Client equipped with custom Global Error Interceptors
* **Dependency Injection:** GetIt Service Locator
* **Local Caching:** SharedPreferences Persistence
