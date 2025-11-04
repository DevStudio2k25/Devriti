# DEVRITI - Mental Health Companion App

**"Instant help, no login needed — DEVRITI is here for you"** 💙

DEVRITI is an emergency-ready mental health support application built with Flutter. No signup, no login, no barriers - just immediate AI-powered support when you need it most.

## Key Features

- 🤖 **AI Chat Companion** - Gemini 2.0 powered empathetic conversations (NO LOGIN!)
- 😊 **Mood Tracking** - Track and analyze your emotional patterns locally
- 🧘 **Self-Care Tools** - Relaxation sounds, breathing exercises, journaling, and meditation
- 👨‍⚕️ **Professional Connect** - Direct access to therapists and counselors
- 🚨 **Emergency Help** - One-tap access to helplines and emergency contacts
- 📊 **Progress Reports** - Visualize your mental health journey
- 🔒 **100% Private** - All data stored locally on your device
- 🌙 **Dark Mode** - Comfortable viewing in any lighting
- 🌐 **Multi-language** - Support for English and Hindi
- ⚡ **Instant Access** - No authentication barriers in emergencies

## Project Structure

```
lib/
├── core/                 # Core utilities and constants
│   ├── constants/       # App-wide constants
│   └── config/          # Environment configurations
├── data/                # Data layer
│   ├── models/         # Data models
│   ├── repositories/   # Repository implementations
│   └── sources/        # Data sources (local/remote)
├── domain/              # Business logic layer
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── services/       # Business services
└── presentation/        # UI layer
    ├── screens/        # App screens
    ├── widgets/        # Reusable widgets
    └── providers/      # State management
```

## Getting Started

### Prerequisites

- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)
- Android Studio / VS Code
- Gemini API Key (get from Google AI Studio)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/sukoon.git
cd sukoon
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Gemini API:
```dart
// Update lib/core/config/env_config.dart
static const String geminiApiKey = 'YOUR_API_KEY_HERE';
```

4. Run the app:
```bash
flutter run
```

## Configuration

### Environment Setup

The app supports three environments:
- **Development**: For local development
- **Staging**: For testing
- **Production**: For release builds

Configure the environment in `lib/core/config/env_config.dart`.

### Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication (Email/Password and Google Sign-In)
3. Enable Firestore Database
4. Enable Analytics and Crashlytics
5. Run `flutterfire configure` to generate configuration files

## Building

### Android
```bash
flutter build apk --release
# or for split APKs
flutter build apk --split-per-abi
```

### iOS
```bash
flutter build ios --release
```

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Dependencies

Key packages used in this project:
- `google_generative_ai` - Gemini AI integration
- `provider` - State management
- `hive` - Local database (no cloud!)
- `audioplayers` - Audio playback
- `fl_chart` - Charts and graphs
- `url_launcher` - Emergency calls
- `lottie` - Animations

See `pubspec.yaml` for complete list.

## Contributing

Contributions are welcome! Please read our contributing guidelines before submitting PRs.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@sukoon.app or join our community Discord.

## Acknowledgments

- Mental health professionals who provided guidance
- Open source community for amazing packages
- All contributors and testers

---

**Remember: It's okay to not be okay. Reach out for help when you need it.** 💙
