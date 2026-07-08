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
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.19 or higher)
- Dart SDK (3.3 or higher)
- Android Studio / VS Code
- iOS Simulator or Android Emulator

### Installation

```bash
# Clone the repository
git clone <your-repo-url>
# Navigate to project directory
cd my_food_tracker
# Install dependencies
flutter pub get
# Generate code (Riverpod + Drift)
flutter pub run build_runner build --delete-conflicting-outputs
# Run the app
flutter run
```

## 💡 Usage Guide

1. **📊 Check Your Daily Progress**  
   Open the app to see your current calorie consumption vs daily goal with a beautiful animated progress ring.

2. **📸 Scan or Add Meals**  
   Tap the prominent **"ESCANEAR COMIDA"** button (AI camera coming in Phase 2) or use "Añadir alimento manualmente".

3. **📋 Manage Your Food Log**  
   Swipe left on any food item to delete it (with undo option). Tap any entry to see detailed information.

4. **📅 Switch Views**  
   Use the selector (Hoy / Semana / Mes) to explore different time periods and upcoming statistics.

5. **⚙️ Settings & Subscription**  
   Access settings and manage your subscription (30-day free trial → monthly or yearly plan).

---

## 📝 Roadmap

### 🎯 Upcoming Features
- **🤖 AI Food Recognition** – Camera scan with Gemini API or ML Kit
- **📊 Advanced Analytics** – Full integration with `fl_chart` (calories per hour, macros, trends)
- **👤 User Profile** – Personalized goals (weight, activity level, macro targets)
- **🔔 Smart Reminders** – Meal time and hydration notifications
- **📤 Export & Share** – Generate reports and share progress
- **🌐 Cloud Sync** – Backup and multi-device support
- **🏆 Achievements & Streaks** – Gamification elements
- **Freemium System** – Full 30-day trial + paid subscription via RevenueCat + Stripe

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/amazing-feature`)
3. Commit your Changes (`git commit -m 'Add some amazing feature'`)
4. Push to the Branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📧 Contact

**Sergio Sabater**  
Email: sergiosabater@gmail.com

---

<div align="center">
### Start tracking your nutrition today!

*Built with Flutter and passion*

<br><br>

**⭐ If you like the project, give it a star! ⭐**

</div>

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  Made with ❤️ and 🥗 by <strong>Sergio Sabater</strong>
</div>
