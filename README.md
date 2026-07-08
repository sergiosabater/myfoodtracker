# 🍎 MyFoodTracker

<div align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-blue?style=for-the-badge&logo=flutter" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart" alt="Language">
  <img src="https://img.shields.io/badge/Framework-Flutter-02569B?style=for-the-badge&logo=flutter" alt="Framework">
  <img src="https://img.shields.io/badge/State%20Management-Riverpod-purple?style=for-the-badge" alt="State Management">
  <img src="https://img.shields.io/badge/Architecture-Feature--First%20%2B%20Clean-brightgreen?style=for-the-badge" alt="Architecture">
  <img src="https://img.shields.io/badge/Database-Drift%20%28SQLite%29-orange?style=for-the-badge" alt="Database">
</div>

<div align="center">
### Track your food. Master your nutrition.
*The beautiful and intelligent way to log meals, monitor calories, and improve your health with AI-powered insights.*
</div>

---

## 📱 About the Project

**MyFoodTracker** is a modern nutrition tracking app designed to make logging meals effortless and insightful. Whether through quick manual entry or future AI camera scanning, the goal is to help users understand their eating habits, reach daily calorie goals, and build healthier relationships with food.

This project is being developed step by step as a professional-grade learning exercise, built on a solid **Feature-First + Clean Architecture** foundation to ensure scalability, maintainability, and high testability as new features are added.

### ✨ Key Features (Current & Planned)

- 🔥 **Real-time Calorie Progress** – Animated circular progress with daily goal tracking
- 📸 **AI Food Scanner (Coming soon)** – Take a photo and let AI analyze calories and macros
- 📋 **Smart Food Log** – Add, edit, and delete meals with undo support and rich details
- 📊 **Visual Analytics** – Beautiful charts (today/week/month) powered by fl_chart
- 🆓 **Freemium Model** – 30-day full trial, then monthly or yearly subscription
- 🎨 **Premium UI/UX** – Glossy design, smooth animations, shimmer effects, and Material 3

---

## 📸 Screenshots

*(Se añadirán aquí cuando tengamos capturas reales)*

<div align="center">
  <!-- Placeholder para futuras imágenes -->
  <p><strong>Dashboard • Progress Ring • Food List • Scan Button</strong></p>
</div>

---

## 🛠️ Tech Stack

### 🏗️ Framework & Architecture
- **Flutter** – Cross-platform framework for beautiful native apps
- **Dart** – Modern, type-safe language
- **Feature-First + Clean Architecture** – Organized by feature with clear separation of concerns (`presentation` / `domain` / `data`)

### 💉 State Management
- **Riverpod** (`flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`) – Reactive, compile-safe state management with excellent dev experience

### 💾 Data Persistence
- **Drift** – Modern, type-safe SQLite wrapper with reactive streams
- **Repository Pattern** – Clean abstraction between domain and data layer

### 🧭 Navigation
- **GoRouter** – Declarative, type-safe routing

### 🎨 UI & Design
- **Material Design 3** – Modern, expressive design system
- **Custom Theme System** – Centralized `AppTheme` with gradients and glossy effects
- **Animations** – Custom `AnimationController`, shimmer, scale transitions, and more

### 🔮 Future Integrations
- **RevenueCat + Stripe** – Subscription management (freemium model)
- **Google ML Kit / Gemini API** – AI food recognition
- **fl_chart** – Advanced nutrition visualizations

---

## 🗺️ Project Structure

```plaintext
📦 lib/
 ┣ 📂 core/
 ┃ ┣ 📂 di/           # Providers globales
 ┃ ┣ 📂 routes/       # GoRouter configuration
 ┃ ┣ 📂 theme/        # AppTheme y estilos
 ┃ ┗ 📂 utils/
 ┣ 📂 features/
 ┃ ┣ 📂 home/
 ┃ ┣ 📂 food_log/
 ┃ ┃ ┣ 📂 data/
 ┃ ┃ ┣ 📂 domain/
 ┃ ┃ ┗ 📂 presentation/
 ┃ ┣ 📂 scan/
 ┃ ┣ 📂 statistics/
 ┃ ┗ 📂 subscription/
 ┣ 📂 shared/
 ┃ ┣ 📂 widgets/
 ┃ ┗ 📂 models/
 ┗ 🚀 main.dart
