# Sukoon App - Quick Start Guide

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.x or higher
- Dart SDK 3.x or higher
- Android Studio / VS Code
- Firebase account (for backend services)

### Installation Steps

#### 1. Install Dependencies
```bash
flutter pub get
```

#### 2. Generate Hive Adapters
The app uses Hive for local storage. Generate the type adapters:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### 3. Configure Firebase

**Option A: Using FlutterFire CLI (Recommended)**
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

**Option B: Manual Configuration**
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android and iOS apps
3. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Place them in the correct directories
5. Enable Authentication, Firestore, Analytics, and Crashlytics

#### 4. Run the App
```bash
# Run on connected device
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run in release mode
flutter run --release
```

## 📱 App Features

### 1. Welcome & Onboarding
- Beautiful animated welcome screen
- Language selection (English/Hindi)
- Guest mode option

### 2. Authentication
- Email/Password login
- Google Sign-In
- Guest mode (no account needed)
- Optional profile information

### 3. Home Dashboard
- Personalized greeting
- 6 feature cards:
  - 💬 Chat Now
  - 😊 Track Mood
  - 🧘 Self-Care Tools
  - 👨‍⚕️ Consult Doctor
  - 🚨 Emergency Help
  - 📊 Reports
- Random inspirational quotes

### 4. AI Chat Companion
- WhatsApp-style chat interface
- Emotion detection (calm/neutral/stressed)
- Typing indicator
- Suggested activities
- "Talk to Doctor" escalation

### 5. Mood Tracker
- 5 emoji mood selector (😄 😊 😐 😔 😢)
- Optional notes
- Mood history
- Weekly trends

### 6. Self-Care Tools
**Four Tabs:**
- 🎧 **Relax Sounds**: Rain, ocean, forest, flute
- 🌬️ **Breathing Exercise**: Animated breathing guide
- 📔 **My Journal**: Personal journaling
- 🌙 **Sleep Corner**: Guided meditations

### 7. Doctor Connect
- List of verified professionals
- Filter by specialization
- Call, book, or chat options
- Ratings and experience

### 8. Emergency Help
- Big red SOS button
- Call emergency contact
- Share location
- Mental health helplines (AASRA, Snehi, etc.)

### 9. Reports & Analytics
- Progress visualization
- Mood trends
- Self-care statistics
- PDF export

### 10. Settings
- Profile management
- Dark/Light mode toggle
- Language selection
- Data export/delete
- About section

## 🎨 Customization

### Colors
Edit `lib/core/constants/app_colors.dart`:
```dart
static const Color skyBlue = Color(0xFF87CEEB);
static const Color lavender = Color(0xFFE6E6FA);
static const Color pastelGreen = Color(0xFFB4E7CE);
```

### Text Styles
Edit `lib/core/constants/app_text_styles.dart`

### App Constants
Edit `lib/core/constants/app_constants.dart`:
- App name and tagline
- Helpline numbers
- Quotes
- Age groups

### Localization
Add translations in:
- `lib/core/localization/app_localizations_en.dart`
- `lib/core/localization/app_localizations_hi.dart`

## 🔧 Configuration

### Environment Setup
Edit `lib/core/config/env_config.dart` for different environments:
- Development
- Staging
- Production

### Firebase Options
After running `flutterfire configure`, the file will be auto-generated at:
`lib/core/config/firebase_options.dart`

## 📦 Adding Assets

### Audio Files
Place audio files in `assets/audio/`:
- `rain.mp3`
- `ocean.mp3`
- `forest.mp3`
- `flute.mp3`
- `meditation1.mp3`

### Images
Place images in `assets/images/`:
- `logo.png`
- `splash_bg.png`

### Update pubspec.yaml
Assets are already configured in `pubspec.yaml`

## 🧪 Testing

### Run Tests
```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific test file
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter test integration_test/
```

## 📱 Building for Release

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# Split APKs by ABI
flutter build apk --split-per-abi
```

### iOS
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

### Common Issues

**1. Hive Adapter Errors**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**2. Firebase Not Initialized**
- Ensure `flutterfire configure` was run
- Check `google-services.json` and `GoogleService-Info.plist` are in place

**3. Provider Errors**
- Restart IDE
- Run `flutter clean` then `flutter pub get`

**4. Import Errors**
- Run `flutter pub get`
- Restart IDE/Language Server

**5. Build Errors**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## 📚 Project Structure

```
sukoon/
├── lib/
│   ├── core/              # Core utilities
│   ├── data/              # Data layer
│   ├── domain/            # Business logic
│   ├── presentation/      # UI layer
│   └── main.dart          # Entry point
├── assets/                # Images, audio, fonts
├── test/                  # Unit tests
└── integration_test/      # Integration tests
```

## 🔐 Security Notes

- Never commit Firebase config files with real credentials
- Use environment variables for sensitive data
- Enable App Check in Firebase
- Implement proper authentication rules
- Use HTTPS for all API calls

## 📖 Documentation

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Hive Documentation](https://docs.hivedb.dev/)
- [Provider Documentation](https://pub.dev/packages/provider)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 💙 Support

For support or questions:
- Email: support@sukoon.app
- GitHub Issues: [Create an issue](https://github.com/yourusername/sukoon/issues)

---

**"You're not alone — Sukoon is here for you"** 💙

Made with ❤️ for mental health awareness
