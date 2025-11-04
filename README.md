# Sukoon - Mental Health Companion App

**"You're not alone — Sukoon is here for you"**

Sukoon is a comprehensive mental health support application built with Flutter, designed to provide users with accessible, compassionate, and immediate support for their emotional well-being.

## Features

- 🤖 **AI Chat Companion** - Empathetic AI-powered conversations
- 😊 **Mood Tracking** - Track and analyze your emotional patterns
- 🧘 **Self-Care Tools** - Relaxation sounds, breathing exercises, journaling, and meditation
- 👨‍⚕️ **Professional Connect** - Connect with verified therapists and counselors
- 🚨 **Emergency Help** - Quick access to helplines and emergency contacts
- 📊 **Progress Reports** - Visualize your mental health journey
- 🌙 **Dark Mode** - Comfortable viewing in any lighting
- 🌐 **Multi-language** - Support for English and Hindi

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
- Firebase account (for authentication and backend)

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

3. Configure Firebase:
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
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
- `provider` - State management
- `hive` - Local database
- `firebase_auth` - Authentication
- `firebase_firestore` - Cloud database
- `audioplayers` - Audio playback
- `fl_chart` - Charts and graphs
- `geolocator` - Location services
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
