# DEVRITI - Mental Health Companion App

**"Instant help, no login needed — DEVRITI is here for you"** 💙

DEVRITI is an emergency-ready mental health support application built with Flutter for Android. No signup, no login, no barriers - just immediate AI-powered support when you need it most.

---

## 📱 **App Overview**

DEVRITI ek comprehensive mental health support app hai jo crisis situations mein instant help provide karta hai. Iska unique approach hai **"No Login Required"** - matlab emergency mein koi barrier nahi. App completely offline-first hai with local data storage for 100% privacy.

**Target Platform:** Android  
**Framework:** Flutter 3.9.2  
**Architecture:** Clean Architecture (3-layer: Presentation, Domain, Data)  
**Design Style:** Neumorphic (3D soft UI with depth effects)

---

## ✨ **Complete Feature List**

### 1. 🤖 **AI Chat Companion** (Core Feature)
**No Login Required - Instant Access**

- **Gemini 2.0 Flash AI Integration** with custom mental health prompts
- **Advanced Emotion Detection** - 10+ emotion states (happy, sad, anxious, stressed, etc.)
- **Context-Aware Responses** - AI understands user's emotional state
- **Crisis Detection** - Automatic detection of suicide/self-harm keywords
- **Smart Suggestions** - Personalized recommendations based on conversation
- **Chat History** - All conversations saved locally with Hive database
- **Typing Animations** - Smooth typing indicators and text animations
- **5 Custom AI Rule Files:**
  - System prompt configuration
  - Conversation rules (greetings, sadness, anxiety responses)
  - Advanced therapeutic techniques (CBT, DBT protocols)
  - Emotion detection algorithms
  - Crisis intervention protocols

**Technical Implementation:**
- Stream-based real-time messaging
- Custom message models with Hive adapters
- Repository pattern for data management
- Fallback responses for API failures
- Safety settings for content filtering

---

### 2. 🚨 **Emergency Help System**

- **Animated SOS Button** - Pulsing effect with animation controller
- **One-Tap Emergency Contact Calling** - Direct call to saved emergency contact
- **Quick Action Grid:**
  - 📞 Call Emergency Contact
  - 💬 Message Emergency Contact
  - 🏥 Find Nearest Hospital
  - 🆘 Call Mental Health Helpline
- **Pre-configured Helplines:**
  - AASRA: 9152987821
  - Vandrevala Foundation: 9999666555
  - iCall: 9152987821
  - Snehi: 9152987821
- **Emergency Contact Management** - Save contact details in profile
- **Warning Banner** - Crisis situation awareness
- **URL Launcher Integration** - Direct calling functionality

---

### 3. 🧘 **Self-Care Tools**

**Breathing Exercises:**
- 4-7-8 Breathing Technique
- Box Breathing
- Guided breathing animations
- Timer functionality

**Relaxation Sounds:**
- Audio player integration (audioplayers + just_audio)
- Multiple calming sound options
- Background playback support
- Play/pause controls

**Meditation & Journaling:**
- Guided meditation sessions
- Private mood journaling
- Local storage only (100% private)

---

### 4. 👨‍⚕️ **Professional Connect**

- **Doctor/Counselor Directory** with profiles
- **Filter by Specialization:**
  - Clinical Psychologist
  - Psychiatrist
  - Counselling Psychologist
  - Child Psychologist
- **Professional Details:**
  - Name, specialization, experience
  - Rating system (4.7-4.9 stars)
  - Availability status
  - Contact number
- **One-Tap Calling** - Direct call via url_launcher
- **Filter Chips** - Easy filtering (All, Counsellor, Psychiatrist)

---

### 5. 👤 **User Profile & Authentication**

**Firebase Authentication:**
- Email/Password login
- Google Sign-in integration
- Password reset flow
- Session persistence

**Profile Management:**
- Personal Information (Name, Age, Gender, Profession)
- Emergency Contact Details (Name, Phone, Relation)
- Profile Picture support
- Edit profile functionality
- Logout option

**Profile Setup Wizard:**
- Step-by-step onboarding
- Data validation
- Smooth transitions

---

### 6. 📊 **Reports & Analytics**

- **Mood Tracking Visualization** - fl_chart library integration
- **Weekly Review Charts** - Line and bar charts
- **Progress Reports** - Track mental health journey
- **Insights Section** - Recent insights display
- **PDF Generation** - Export reports (pdf + printing packages)
- **Data Analysis** - Patterns and trends

---

### 7. 📅 **Daily Routine Management**

- **Add/Edit Routines** - Custom routine builder
- **Activity Tracking:**
  - Morning Meditation (8:00 AM)
  - Take Medication (10:00 AM)
  - Evening Walk (6:00 PM)
- **Completion Status** - Check/uncheck activities
- **Time Management** - Scheduled activities
- **Visual Indicators** - Icons and colors for each activity

---

### 8. 🏠 **Home Dashboard**

**Welcome Card:**
- Personalized greeting
- App mascot/logo
- User name display

**AI Support Card:**
- Quick access to AI chat
- Feature highlights

**Dashboard Grid:**
- Quick access tiles to all features
- Icon-based navigation
- Neumorphic card design

**Motivational Quotes:**
- Random daily inspiration
- Quote rotation system
- Beautiful card design

**Week in Review:**
- Weekly activity chart
- Progress visualization

**Today's Activities:**
- Activity list with status
- Time-based organization
- Completion tracking

---

### 9. 🌐 **Multi-language Support**

- **English & Hindi** localization
- **Dynamic Language Switching** - Change language on-the-fly
- **Localized Strings** - All UI elements translated
- **Language Provider** - State management for language
- **Persistent Preference** - Saved in SharedPreferences

---

### 10. 🌙 **Theme System**

- **Light Mode** - Clean, bright interface
- **Dark Mode** - Eye-friendly dark theme
- **Neumorphic Design System:**
  - 3D depth effects
  - Soft shadows
  - Elevated cards
  - Custom color palette (Purple, Mint, Coral, Blue, Orange)
- **Smooth Transitions** - Animated theme switching
- **Theme Provider** - State management
- **Persistent Theme** - Saved preference

---

### 11. ⚙️ **Settings & Configuration**

- **Theme Toggle** - Light/Dark mode switch
- **Language Selection** - English/Hindi
- **Notification Settings** (structure ready)
- **Privacy Settings**
- **About Section** - App info and version
- **Logout Option**

---

### 12. 🎨 **Additional Features**

- **Splash Screen** - Animated app launch
- **Custom Navigation** - Bottom nav + Side drawer
- **Lottie Animations** - Smooth vector animations
- **Shimmer Effects** - Loading placeholders
- **Staggered Animations** - List item animations
- **Cached Images** - Optimized image loading
- **Offline Support** - Works without internet (except AI chat)
- **About Screen** - App information and credits
- **AI Profile Screen** - AI companion details

---

## 🏗️ **Technical Architecture**

### **Clean Architecture (3 Layers):**

```
lib/
├── core/                    # Core utilities and configurations
│   ├── config/             # Environment & Gemini rules
│   ├── constants/          # App-wide constants (colors, spacing, text styles)
│   ├── di/                 # Dependency injection (service locator)
│   ├── localization/       # Multi-language support (EN, HI)
│   ├── navigation/         # App routing
│   ├── theme/              # Theme configuration
│   └── widgets/            # Reusable neumorphic widgets
│
├── features/               # Feature modules (12 modules)
│   ├── splash/            # Splash screen
│   ├── auth/              # Authentication (login, signup, profile setup)
│   ├── home/              # Home dashboard & main screen
│   ├── chat/              # AI chat companion
│   ├── self_care/         # Self-care tools
│   ├── emergency/         # Emergency help system
│   ├── doctor/            # Professional connect
│   ├── profile/           # User profile (view & edit)
│   ├── reports/           # Reports & analytics
│   ├── routine/           # Daily routine management
│   ├── settings/          # App settings
│   ├── about/             # About screen
│   └── ai_profile/        # AI companion profile
│
└── shared/                # Shared providers
    └── providers/         # Theme & Language providers
```

### **Code Statistics:**
- **Total Dart Files:** 102 files
- **Total Screens:** 20+ screens
- **Custom Widgets:** 50+ reusable components
- **Feature Modules:** 12 major modules
- **Lines of Code:** ~8,000-10,000 lines

---

## 🛠️ **Technology Stack**

### **Core Technologies:**
- **Flutter SDK:** 3.9.2
- **Dart SDK:** 3.9.2
- **Platform:** Android

### **State Management:**
- **Provider:** ^6.1.1 - State management pattern

### **Backend & Database:**
- **Firebase Core:** ^3.6.0 - Firebase initialization
- **Firebase Auth:** ^5.3.1 - User authentication
- **Cloud Firestore:** ^5.4.4 - Cloud database
- **Hive:** ^2.2.3 - Local NoSQL database
- **Hive Flutter:** ^1.1.0 - Hive Flutter integration
- **SharedPreferences:** ^2.2.2 - Key-value storage

### **AI Integration:**
- **Google Generative AI:** ^0.4.6 - Gemini 2.0 Flash API

### **Network & API:**
- **Dio:** ^5.4.0 - HTTP client
- **HTTP:** ^1.1.2 - HTTP requests

### **Location & Permissions:**
- **Geolocator:** ^10.1.0 - Location services
- **Permission Handler:** ^11.1.0 - Runtime permissions

### **External Actions:**
- **URL Launcher:** ^6.2.2 - Phone calls, SMS, browser
- **Share Plus:** ^7.2.1 - Share functionality
- **Image Picker:** ^1.0.7 - Camera/gallery access

### **Audio:**
- **Audioplayers:** ^5.2.1 - Audio playback
- **Just Audio:** ^0.9.36 - Advanced audio player

### **Charts & Visualization:**
- **FL Chart:** ^0.65.0 - Beautiful charts and graphs

### **PDF & Documents:**
- **PDF:** ^3.10.7 - PDF generation
- **Printing:** ^5.11.1 - Print/share PDFs

### **UI Components:**
- **Flutter SVG:** ^2.0.9 - SVG rendering
- **Lottie:** ^2.7.0 - Lottie animations
- **Shimmer:** ^3.0.0 - Shimmer loading effects
- **Cached Network Image:** ^3.3.1 - Image caching
- **Flutter Staggered Animations:** ^1.1.1 - List animations

### **Utilities:**
- **Intl:** ^0.20.2 - Internationalization
- **UUID:** ^4.3.3 - Unique ID generation
- **Path Provider:** ^2.1.2 - File system paths
- **Connectivity Plus:** ^5.0.2 - Network status

### **Development Tools:**
- **Flutter Lints:** ^5.0.0 - Linting rules
- **Hive Generator:** ^2.0.1 - Code generation for Hive
- **Build Runner:** ^2.4.7 - Code generation
- **Mockito:** ^5.4.4 - Testing mocks
- **Flutter Launcher Icons:** ^0.13.1 - App icon generation

---

## 🎨 **Design System**

### **Neumorphic Design:**
- **Style:** 3D soft UI with depth effects
- **Shadows:** Dual shadows (light + dark) for depth
- **Elevation:** Multiple elevation levels
- **Shapes:** Rounded corners, circular elements

### **Color Palette:**
```dart
Primary Colors:
- Purple: #8B7FFF (Primary brand color)
- Mint: #7FFFD4 (Success, calm)
- Coral: #FF7F7F (Alerts, energy)
- Blue: #7FB3FF (Info, trust)
- Orange: #FFB366 (Motivation, warmth)

Neutral Colors:
- Background: #F0F0F3 (Light) / #1E1E1E (Dark)
- Card: #FFFFFF (Light) / #2A2A2A (Dark)
- Text Primary: #2C2C2C (Light) / #FFFFFF (Dark)
- Text Secondary: #666666 (Light) / #AAAAAA (Dark)
- Text Tertiary: #999999 (Light) / #777777 (Dark)
```

### **Typography:**
- **Font Family:** System default (Roboto on Android)
- **Heading 1:** 28px, Bold
- **Heading 2:** 24px, Bold
- **Heading 3:** 20px, SemiBold
- **Body:** 16px, Regular
- **Caption:** 14px, Regular
- **Small:** 12px, Regular

### **Spacing System:**
- **xs:** 4px
- **sm:** 8px
- **md:** 16px
- **lg:** 24px
- **xl:** 32px
- **xxl:** 48px

### **Custom Widgets:**
- NeumorphicCard
- NeumorphicButton
- NeumorphicContainer
- NeumorphicTextField
- Custom animations and transitions

---

## 🔄 **User Flow**

```
App Launch
    ↓
Splash Screen (2s animation)
    ↓
Home Dashboard (No Login Required!)
    ↓
┌─────────────────────────────────────────────┐
│  Bottom Navigation (5 Tabs):               │
│  1. 🏠 Home - Dashboard & overview         │
│  2. 💬 Chat - AI Companion (Instant!)      │
│  3. 🧘 Self-Care - Tools & exercises       │
│  4. 🚨 Emergency - Crisis help             │
│  5. 👤 Profile - User settings (Optional)  │
└─────────────────────────────────────────────┘
    ↓
Side Drawer (Additional Features):
  - 👨‍⚕️ Doctor Connect
  - 📊 Reports & Analytics
  - 📅 Daily Routine
  - ⚙️ Settings
  - ℹ️ About
  - 🤖 AI Profile
```

### **Critical Flow - Emergency:**
```
User in Crisis
    ↓
Opens App (No Login Needed!)
    ↓
Tap Emergency Tab
    ↓
Tap SOS Button (Animated)
    ↓
One-Tap Call to Emergency Contact / Helpline
    ↓
Instant Help!
```

### **AI Chat Flow:**
```
User Opens Chat
    ↓
Types Message (e.g., "I'm feeling anxious")
    ↓
AI Detects Emotion (Anxiety)
    ↓
Gemini 2.0 Generates Empathetic Response
    ↓
Smart Suggestions Displayed:
  - 🫁 5-minute breathing exercise
  - 🎵 Calming sounds
  - 📝 Journal your feelings
    ↓
User Selects Action or Continues Chat
```

---

## 🔐 **Privacy & Security**

- **Local-First:** All personal data stored locally with Hive
- **No Cloud Sync:** Chat history never leaves device
- **Firebase Auth:** Secure authentication (optional)
- **Encrypted Storage:** Hive provides encryption support
- **No Tracking:** No analytics on sensitive conversations
- **Offline Mode:** Works without internet (except AI chat)

---

## 📦 **Assets Structure**

```
assets/
├── images/
│   ├── app_logo.jpg
│   └── logo_devriti.png
├── icons/
│   └── (Custom icons - structure ready)
├── audio/
│   └── (Relaxation sounds - structure ready)
├── animations/
│   └── (Lottie files - structure ready)
└── fonts/
    └── (Custom fonts - structure ready)
```

---

## 🚀 **App Capabilities**

### **What Works:**
✅ AI Chat with Gemini 2.0 (requires API key)  
✅ User authentication (Firebase)  
✅ Profile management  
✅ Emergency calling  
✅ Doctor directory  
✅ Theme switching (Light/Dark)  
✅ Language switching (EN/HI)  
✅ Navigation system  
✅ Local data storage  
✅ Charts and reports UI  
✅ Routine management UI  
✅ Settings panel  

### **Structure Ready (Needs Assets):**
⏳ Audio playback (audio files needed)  
⏳ Lottie animations (animation files needed)  
⏳ Custom fonts (font files needed)  

---

## 🎯 **Key Highlights**

1. **No Login Barrier** - Instant access in emergencies
2. **Advanced AI** - Gemini 2.0 with custom mental health rules
3. **Crisis Detection** - Automatic suicide/self-harm keyword detection
4. **100% Private** - All data stored locally
5. **Neumorphic Design** - Modern, calming 3D UI
6. **Clean Architecture** - Scalable, maintainable codebase
7. **Offline-First** - Works without internet (except AI)
8. **Multi-language** - English + Hindi support
9. **Emergency Ready** - One-tap helpline access
10. **Professional Connect** - Direct access to therapists

## 🚀 **Getting Started**

### **Prerequisites:**
- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / VS Code
- Android device or emulator
- Gemini API Key (from Google AI Studio)
- Firebase project (for authentication)

### **Installation Steps:**

1. **Clone the repository:**
```bash
git clone <repository-url>
cd devriti
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Configure Gemini API:**
```dart
// Create: lib/core/config/env_config.dart
class EnvConfig {
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
}
```

4. **Firebase Setup:**
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

5. **Enable Firebase Services:**
   - Authentication (Email/Password + Google Sign-in)
   - Cloud Firestore
   - Analytics (optional)

6. **Run the app:**
```bash
flutter run
```

### **Build APK:**
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APKs (smaller size)
flutter build apk --split-per-abi --release
```

---

## 📝 **Configuration Files**

### **Environment Config:**
```dart
// lib/core/config/env_config.dart
class EnvConfig {
  static const String geminiApiKey = 'YOUR_API_KEY';
  static const String environment = 'production'; // development, staging, production
}
```

### **Firebase Options:**
- Auto-generated: `lib/firebase_options.dart`
- Created by: `flutterfire configure`

### **App Constants:**
```dart
// lib/core/constants/app_constants.dart
- App name, version
- Helpline numbers
- Motivational quotes
- Default values
```

---

## 🧪 **Testing**

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/features/chat/chat_service_test.dart
```

**Note:** Test files structure ready, implementation pending.

---

## 📱 **App Permissions (Android)**

Required permissions in `AndroidManifest.xml`:
- `INTERNET` - For AI chat and Firebase
- `CALL_PHONE` - For emergency calling
- `ACCESS_FINE_LOCATION` - For finding nearby hospitals
- `READ_EXTERNAL_STORAGE` - For profile pictures
- `WRITE_EXTERNAL_STORAGE` - For saving reports

---

## 🔧 **Troubleshooting**

### **Common Issues:**

**1. Gemini API Error:**
```
Solution: Check API key in env_config.dart
Verify: API key is active in Google AI Studio
```

**2. Firebase Auth Error:**
```
Solution: Run 'flutterfire configure' again
Check: google-services.json exists in android/app/
```

**3. Hive Error:**
```
Solution: Run 'flutter pub run build_runner build'
Clean: flutter clean && flutter pub get
```

**4. Build Error:**
```
Solution: flutter clean
Then: flutter pub get
Finally: flutter run
```

---

## 📚 **Documentation**

### **Code Documentation:**
- Each feature module has inline comments
- Complex logic explained with comments
- Gemini rules documented in separate files

### **Architecture Documentation:**
- Clean Architecture pattern followed
- Repository pattern for data layer
- Provider pattern for state management

### **API Documentation:**
- Gemini API: https://ai.google.dev/docs
- Firebase: https://firebase.google.com/docs

---

## 🎯 **Future Enhancements**

### **Planned Features:**
- [ ] Video call with therapists
- [ ] Group therapy sessions
- [ ] Medication reminders with notifications
- [ ] Wearable device integration
- [ ] AI voice chat
- [ ] Community support forums
- [ ] Gamification (wellness streaks, badges)
- [ ] Export data to PDF
- [ ] Backup & restore functionality

### **Technical Improvements:**
- [ ] Unit test coverage
- [ ] Widget test coverage
- [ ] Integration tests
- [ ] CI/CD pipeline
- [ ] Performance monitoring
- [ ] Crash reporting (Firebase Crashlytics)
- [ ] Analytics dashboard
- [ ] Push notifications

---

## 🤝 **Contributing**

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### **Code Style:**
- Follow Flutter/Dart style guide
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused

---

## 📄 **License**

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 **Acknowledgments**

- **Mental Health Professionals** - For guidance on crisis protocols
- **Flutter Community** - For amazing packages and support
- **Google AI** - For Gemini 2.0 Flash API
- **Firebase** - For backend infrastructure
- **Open Source Contributors** - For all the packages used

---

## 📞 **Support & Contact**

For support, questions, or feedback:
- Email: support@devriti.app
- GitHub Issues: [Create an issue]
- Documentation: [Wiki section]

---

## ⚠️ **Important Notes**

1. **API Keys:** Never commit API keys to version control
2. **Firebase Config:** Keep `google-services.json` secure
3. **Mental Health:** This app is a support tool, not a replacement for professional help
4. **Emergency:** Always call emergency services (112) in life-threatening situations
5. **Privacy:** User data is stored locally, handle with care

---

## 🌟 **App Screenshots**

*(Screenshots can be added here)*

- Home Dashboard
- AI Chat Interface
- Emergency Screen
- Self-Care Tools
- Profile Management
- Reports & Analytics

---

**Remember: It's okay to not be okay. Reach out for help when you need it.** 💙

**DEVRITI - Your Mental Health Companion** 🌸
