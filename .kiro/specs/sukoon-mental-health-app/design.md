# Design Document

## Overview

Sukoon is a Flutter-based mobile application designed to provide comprehensive mental health support through multiple channels: AI-powered conversations, mood tracking, self-care activities, professional consultations, and emergency assistance. The application prioritizes user privacy, accessibility, and a calming user experience through thoughtful design and empathetic interactions.

The architecture follows a clean, modular approach with clear separation between presentation, business logic, and data layers. The app supports both authenticated and guest modes, offline functionality for core features, and secure data handling for sensitive mental health information.

## Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  (Screens, Widgets, State Management - Provider/Riverpod)   │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                      Business Logic Layer                    │
│        (Services, Use Cases, Validators, Managers)           │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                        Data Layer                            │
│    (Repositories, Data Sources, Models, API Clients)         │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌──────────────────┬──────────────────┬──────────────────────┐
│  Local Storage   │   Remote API     │   External Services  │
│  (Hive/SQLite)   │   (REST/GraphQL) │   (Firebase, Maps)   │
└──────────────────┴──────────────────┴──────────────────────┘
```

### Layer Responsibilities

**Presentation Layer:**
- Screen widgets and UI components
- State management using Provider or Riverpod
- User input handling and validation
- Navigation and routing
- Animation and visual effects

**Business Logic Layer:**
- Core application logic and use cases
- Data transformation and validation
- Service orchestration
- Business rules enforcement
- Event handling

**Data Layer:**
- Data persistence (local and remote)
- API communication
- Data models and serialization
- Caching strategies
- Repository pattern implementation

## Components and Interfaces

### 1. Authentication Module

**Components:**
- `AuthService`: Handles user authentication flows
- `AuthRepository`: Manages auth data persistence
- `UserModel`: Represents user data structure
- `GuestModeManager`: Manages anonymous user sessions

**Key Interfaces:**
```dart
abstract class IAuthService {
  Future<User?> signInWithEmail(String email, String password);
  Future<User?> signInWithGoogle();
  Future<User?> continueAsGuest();
  Future<void> signOut();
  Stream<User?> get authStateChanges;
}
```

### 2. Onboarding Module

**Components:**
- `OnboardingScreen`: Welcome and language selection
- `LanguageService`: Manages app localization
- `AnimationController`: Handles background animations

**Features:**
- Smooth gradient animations
- Language persistence
- First-time user detection

### 3. Chat/AI Companion Module

**Components:**
- `ChatService`: Manages conversation flow
- `AIResponseGenerator`: Generates empathetic responses
- `EmotionAnalyzer`: Analyzes user sentiment
- `ChatRepository`: Stores conversation history
- `MessageModel`: Represents chat messages

**Key Interfaces:**
```dart
abstract class IChatService {
  Future<Message> sendMessage(String text);
  Stream<Message> get messageStream;
  Future<EmotionState> analyzeEmotion(String text);
  Future<List<SuggestedActivity>> getSuggestions(EmotionState state);
}
```

**Emotion Detection:**
- Keyword analysis for distress signals
- Sentiment scoring (0-100)
- Color coding: Blue (calm), Yellow (neutral), Red (stressed)
- Automatic escalation triggers

### 4. Mood Tracking Module

**Components:**
- `MoodTrackerService`: Manages mood entries
- `MoodRepository`: Persists mood data
- `MoodAnalytics`: Generates trends and insights
- `MoodModel`: Represents mood entry data

**Key Interfaces:**
```dart
abstract class IMoodTrackerService {
  Future<void> saveMoodEntry(MoodEntry entry);
  Future<List<MoodEntry>> getMoodHistory(DateRange range);
  Future<MoodTrend> analyzeTrend(DateRange range);
  Future<MoodInsights> generateInsights();
}
```

**Data Structure:**
```dart
class MoodEntry {
  String id;
  DateTime timestamp;
  MoodLevel mood; // 😄 😊 😐 😔 😢
  String? note;
  List<String> tags;
}
```

### 5. Self-Care Tools Module

**Components:**
- `SelfCareService`: Manages self-care activities
- `AudioPlayer`: Plays relaxation sounds
- `BreathingExerciseController`: Animates breathing guide
- `JournalRepository`: Stores journal entries
- `MeditationPlayer`: Handles meditation audio

**Sub-modules:**

**a) Relax Sounds:**
- Audio library: rain, ocean, flute, forest, white noise
- Volume control and mixing
- Background playback support
- Timer functionality

**b) Breathing Exercise:**
- Animated circle (expand/contract)
- Customizable timing (4-7-8, box breathing)
- Visual and haptic feedback
- Session tracking

**c) Journal:**
- Rich text editor
- Gratitude prompts
- Mood tagging
- Search and filter

**d) Sleep Corner:**
- Guided meditation library
- Sleep stories
- Ambient soundscapes
- Sleep timer

### 6. Doctor Connect Module

**Components:**
- `ProfessionalService`: Manages therapist data
- `BookingService`: Handles appointment scheduling
- `CommunicationService`: Manages calls and chats
- `ProfessionalModel`: Represents therapist data

**Key Interfaces:**
```dart
abstract class IProfessionalService {
  Future<List<Professional>> searchProfessionals(SearchFilter filter);
  Future<void> bookAppointment(String professionalId, DateTime slot);
  Future<void> initiateCall(String professionalId);
  Future<void> startChat(String professionalId);
}
```

**Professional Data:**
```dart
class Professional {
  String id;
  String name;
  String photoUrl;
  String specialization;
  List<String> languages;
  double rating;
  int experienceYears;
  bool isAvailable;
  List<TimeSlot> availableSlots;
}
```

### 7. Emergency Module

**Components:**
- `EmergencyService`: Handles SOS actions
- `LocationService`: Manages location sharing
- `ContactService`: Manages emergency contacts
- `HelplineRepository`: Stores helpline numbers

**Key Interfaces:**
```dart
abstract class IEmergencyService {
  Future<void> triggerSOS();
  Future<void> callEmergencyContact();
  Future<void> shareLocation();
  Future<List<Helpline>> getHelplines(String country);
  Future<void> sendAutoMessage(String message);
}
```

**Safety Features:**
- One-tap SOS activation
- Automatic location detection
- SMS fallback if internet unavailable
- Multiple emergency contact support

### 8. Reports & Analytics Module

**Components:**
- `ReportsService`: Generates analytics
- `ChartGenerator`: Creates visual graphs
- `PDFGenerator`: Exports reports
- `ProgressCalculator`: Computes improvement metrics

**Key Interfaces:**
```dart
abstract class IReportsService {
  Future<MoodReport> generateMoodReport(DateRange range);
  Future<ActivityReport> generateActivityReport(DateRange range);
  Future<File> exportToPDF(Report report);
  Future<ProgressMetrics> calculateProgress();
}
```

**Metrics Tracked:**
- Mood frequency distribution
- Mood trend direction
- Self-care session count
- Chat engagement
- Improvement percentage

### 9. Settings Module

**Components:**
- `SettingsService`: Manages app preferences
- `ThemeService`: Handles dark/light mode
- `PrivacyService`: Manages data and privacy
- `ProfileService`: Handles user profile

**Key Interfaces:**
```dart
abstract class ISettingsService {
  Future<void> updateProfile(UserProfile profile);
  Future<void> setThemeMode(ThemeMode mode);
  Future<void> deleteUserData();
  Future<void> exportUserData();
  Stream<AppSettings> get settingsStream;
}
```

## Data Models

### Core Models

```dart
// User Model
class User {
  String id;
  String? name;
  String? email;
  AgeGroup? ageGroup;
  String? emergencyContact;
  bool isGuest;
  DateTime createdAt;
  UserPreferences preferences;
}

// Message Model
class Message {
  String id;
  String text;
  MessageType type; // user, ai, system
  DateTime timestamp;
  EmotionState? emotion;
  List<SuggestedAction>? suggestions;
}

// Mood Entry Model
class MoodEntry {
  String id;
  MoodLevel mood;
  String? note;
  DateTime timestamp;
  List<String> tags;
}

// Self-Care Session Model
class SelfCareSession {
  String id;
  SelfCareType type; // sound, breathing, journal, meditation
  DateTime startTime;
  DateTime? endTime;
  int durationMinutes;
  Map<String, dynamic> metadata;
}

// Professional Model
class Professional {
  String id;
  String name;
  String photoUrl;
  String specialization;
  List<String> languages;
  double rating;
  ContactInfo contactInfo;
}
```

## Error Handling

### Error Categories

1. **Network Errors:**
   - Offline mode activation
   - Cached data display
   - Retry mechanisms
   - User-friendly error messages

2. **Authentication Errors:**
   - Invalid credentials handling
   - Session expiry management
   - Guest mode fallback

3. **Data Errors:**
   - Validation failures
   - Sync conflicts
   - Data corruption recovery

4. **External Service Errors:**
   - AI service unavailability
   - Payment gateway failures
   - Location service errors

### Error Handling Strategy

```dart
class AppError {
  ErrorType type;
  String message;
  String? userMessage;
  StackTrace? stackTrace;
  
  static String getUserFriendlyMessage(ErrorType type) {
    // Return calming, supportive error messages
  }
}
```

**User-Facing Error Messages:**
- Avoid technical jargon
- Provide actionable solutions
- Maintain calming tone
- Offer alternative actions

## Testing Strategy

### Unit Testing

**Coverage Areas:**
- Business logic services
- Data models and serialization
- Validators and utilities
- State management logic

**Tools:**
- `flutter_test` package
- `mockito` for mocking
- `fake_async` for time-based tests

### Widget Testing

**Coverage Areas:**
- Individual screen widgets
- Custom UI components
- User interaction flows
- Animation controllers

**Focus:**
- Accessibility compliance
- Responsive layouts
- Theme consistency

### Integration Testing

**Coverage Areas:**
- End-to-end user flows
- API integration
- Database operations
- Navigation flows

**Critical Flows:**
1. Onboarding → Home → Chat
2. Mood tracking → Reports
3. Emergency SOS activation
4. Professional booking flow

### Performance Testing

**Metrics:**
- App launch time < 2 seconds
- Screen transition < 300ms
- Chat response time < 1 second
- Mood graph rendering < 500ms

### Accessibility Testing

**Requirements:**
- Screen reader support
- Minimum touch target size: 48x48dp
- Color contrast ratio: 4.5:1
- Keyboard navigation support

## Security & Privacy

### Data Protection

1. **Encryption:**
   - At-rest encryption for local data
   - TLS 1.3 for network communication
   - End-to-end encryption for chat (optional)

2. **Authentication:**
   - OAuth 2.0 for Google sign-in
   - JWT tokens for session management
   - Biometric authentication support

3. **Data Minimization:**
   - Collect only essential data
   - Anonymous analytics
   - Guest mode with no data collection

4. **User Control:**
   - Data export functionality
   - Complete data deletion
   - Granular privacy settings

### Compliance

- GDPR compliance for EU users
- HIPAA considerations for health data
- Local data protection laws
- Age verification for minors

## UI/UX Design Principles

### Visual Design

**Color Palette:**
- Primary: Sky Blue (#87CEEB)
- Secondary: Lavender (#E6E6FA)
- Accent: Pastel Green (#B4E7CE)
- Background: Soft White (#F8F9FA)
- Text: Charcoal (#36454F)

**Typography:**
- Primary Font: Inter or Poppins
- Headings: 24-32sp, Semi-bold
- Body: 16sp, Regular
- Captions: 14sp, Regular

**Spacing:**
- Base unit: 8dp
- Card padding: 16dp
- Screen margins: 20dp
- Element spacing: 12dp

### Animations

1. **Welcome Screen:**
   - Gradient animation (3-second loop)
   - Fade-in for logo and text
   - Slide-up for buttons

2. **Chat Interface:**
   - Typing indicator (3 dots bouncing)
   - Message bubble slide-in
   - Emotion color pulse

3. **Breathing Exercise:**
   - Circle expand/contract (smooth easing)
   - Color transition (blue → green)
   - Haptic feedback on phase change

4. **Mood Selection:**
   - Emoji scale animation
   - Ripple effect on selection
   - Confetti for positive moods

### Accessibility

- High contrast mode support
- Scalable text (up to 200%)
- Voice-over descriptions
- Haptic feedback options
- Reduced motion mode

## Technical Stack

### Core Technologies

- **Framework:** Flutter 3.x
- **Language:** Dart 3.x
- **State Management:** Provider or Riverpod
- **Local Database:** Hive or SQLite
- **Network:** Dio for HTTP requests
- **Authentication:** Firebase Auth
- **Analytics:** Firebase Analytics
- **Crash Reporting:** Firebase Crashlytics

### Key Packages

```yaml
dependencies:
  flutter_localizations: # Internationalization
  provider: ^6.0.0 # State management
  hive: ^2.2.3 # Local storage
  dio: ^5.0.0 # HTTP client
  firebase_core: ^2.0.0 # Firebase
  firebase_auth: ^4.0.0 # Authentication
  google_sign_in: ^6.0.0 # Google auth
  geolocator: ^10.0.0 # Location services
  url_launcher: ^6.1.0 # External links
  share_plus: ^7.0.0 # Sharing functionality
  audioplayers: ^5.0.0 # Audio playback
  fl_chart: ^0.65.0 # Charts and graphs
  pdf: ^3.10.0 # PDF generation
  intl: ^0.18.0 # Date formatting
  shared_preferences: ^2.2.0 # Simple storage
  flutter_svg: ^2.0.0 # SVG support
  lottie: ^2.7.0 # Animations
  shimmer: ^3.0.0 # Loading effects
```

## Deployment Strategy

### Build Variants

1. **Development:**
   - Debug mode
   - Mock API endpoints
   - Verbose logging

2. **Staging:**
   - Release mode
   - Staging API
   - Analytics enabled

3. **Production:**
   - Release mode
   - Production API
   - Optimized assets
   - Obfuscation enabled

### Release Process

1. Version bump
2. Changelog update
3. Automated testing
4. Code review
5. Build generation
6. Internal testing
7. Beta release (TestFlight/Internal Testing)
8. Production release
9. Monitoring and hotfix readiness

## Future Enhancements

### Phase 2 Features

- Group therapy sessions
- Peer support communities
- Wearable device integration
- AI voice conversations
- Personalized content recommendations
- Family member dashboard
- Medication reminders
- Crisis prediction algorithms

### Scalability Considerations

- Microservices architecture for backend
- CDN for media content
- Database sharding for user data
- Caching layers (Redis)
- Load balancing
- Auto-scaling infrastructure
