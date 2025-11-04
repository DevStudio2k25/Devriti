# Requirements Document

## Introduction

Sukoon is a comprehensive mental health support application designed to provide users with accessible, compassionate, and immediate support for their emotional well-being. The application combines AI-powered chat support, mood tracking, self-care tools, professional consultation options, and emergency assistance in a calming, user-friendly interface. The primary goal is to create a safe space where users feel supported and empowered to manage their mental health journey.

## Glossary

- **Sukoon App**: The mobile application system providing mental health support services
- **User**: An individual using the Sukoon App for mental health support
- **AI Companion**: The chatbot system that provides conversational support to Users
- **Mood Entry**: A recorded emotional state with timestamp and optional notes
- **Self-Care Session**: A completed activity from the Self-Care Tools section
- **Emergency Contact**: A designated person who can be contacted during crisis situations
- **Verified Professional**: A licensed therapist or counselor available through the app
- **SOS Action**: An emergency help request triggered by the User
- **Guest Mode**: Application usage without account creation
- **Mood Trend**: Historical visualization of User's emotional states over time

## Requirements

### Requirement 1

**User Story:** As a new user, I want to quickly understand what Sukoon offers and start using it, so that I can access support without barriers.

#### Acceptance Criteria

1. WHEN the User launches the Sukoon App for the first time, THE Sukoon App SHALL display a welcome screen with soft background animation
2. WHEN the welcome screen is displayed, THE Sukoon App SHALL show the app logo, tagline "You're not alone — Sukoon is here for you", and action buttons
3. WHEN the User taps "Get Started", THE Sukoon App SHALL navigate to the login/signup screen
4. WHEN the User taps "Choose Language", THE Sukoon App SHALL display language options for Hindi and English
5. WHEN the User selects a language, THE Sukoon App SHALL apply the selected language to all interface text

### Requirement 2

**User Story:** As a user concerned about privacy, I want to use the app without creating an account, so that I can access support anonymously.

#### Acceptance Criteria

1. WHEN the User views the login/signup screen, THE Sukoon App SHALL display options for email login, Google sign-in, and "Continue as Guest"
2. WHEN the User selects "Continue as Guest", THE Sukoon App SHALL grant access to core features without requiring authentication
3. WHEN the User creates an account, THE Sukoon App SHALL request optional information including name, age group, and emergency contact number
4. WHEN the User completes signup, THE Sukoon App SHALL store user preferences securely
5. WHEN the User logs in successfully, THE Sukoon App SHALL navigate to the home screen

### Requirement 3

**User Story:** As a user, I want a clear dashboard showing all available support options, so that I can quickly access the help I need.

#### Acceptance Criteria

1. WHEN the User accesses the home screen, THE Sukoon App SHALL display a personalized greeting with the user's name
2. WHEN the home screen loads, THE Sukoon App SHALL show five main feature cards: Chat Now, Track Mood, Self-Care Tools, Consult Doctor, and Emergency Help
3. WHEN the home screen is displayed, THE Sukoon App SHALL show an inspirational quote at the top
4. WHEN the User taps any feature card, THE Sukoon App SHALL navigate to the corresponding feature screen
5. WHEN the home screen renders, THE Sukoon App SHALL use card-style layout with calm gradient backgrounds

### Requirement 4

**User Story:** As a user feeling distressed, I want to chat with an AI companion that understands me, so that I can express my feelings and receive supportive responses.

#### Acceptance Criteria

1. WHEN the User opens the chat screen, THE Sukoon App SHALL display a WhatsApp-style chat interface with clean bubbles
2. WHEN the User sends a message, THE Sukoon App SHALL show a typing indicator animation
3. WHEN the AI Companion generates a response, THE Sukoon App SHALL display the message with empathetic and supportive language
4. WHEN the AI Companion detects distress in user messages, THE Sukoon App SHALL suggest relevant self-care activities
5. WHEN the conversation indicates serious concern, THE Sukoon App SHALL display a "Talk to a Doctor" shortcut button
6. WHEN messages are exchanged, THE Sukoon App SHALL show emotion color indicators (blue for calm, red for stressed)

### Requirement 5

**User Story:** As a user, I want to track my daily mood, so that I can understand my emotional patterns over time.

#### Acceptance Criteria

1. WHEN the User opens the mood tracker screen, THE Sukoon App SHALL display five emoji options representing different emotional states
2. WHEN the User selects an emoji, THE Sukoon App SHALL allow adding an optional text note
3. WHEN the User saves a mood entry, THE Sukoon App SHALL record the Mood Entry with timestamp
4. WHEN the mood tracker displays historical data, THE Sukoon App SHALL show a weekly mood graph
5. WHEN the User views past moods, THE Sukoon App SHALL display a list with date, emoji, and notes for each Mood Entry

### Requirement 6

**User Story:** As a user seeking relaxation, I want access to self-care tools, so that I can practice calming techniques and manage stress.

#### Acceptance Criteria

1. WHEN the User opens self-care tools, THE Sukoon App SHALL display four tabs: Relax Sounds, Breathing Exercise, My Journal, and Sleep Corner
2. WHEN the User selects Relax Sounds, THE Sukoon App SHALL provide audio options including rain, ocean, and flute sounds
3. WHEN the User selects Breathing Exercise, THE Sukoon App SHALL display an animated inhale-hold-exhale guide
4. WHEN the User opens My Journal, THE Sukoon App SHALL allow writing and saving personal entries
5. WHEN the User accesses Sleep Corner, THE Sukoon App SHALL provide guided meditation audio for sleep
6. WHEN the User completes a Self-Care Session, THE Sukoon App SHALL record the activity for progress tracking

### Requirement 7

**User Story:** As a user needing professional help, I want to connect with verified therapists, so that I can receive expert mental health support.

#### Acceptance Criteria

1. WHEN the User opens the doctor connect screen, THE Sukoon App SHALL display a list of Verified Professionals with photos, names, and specializations
2. WHEN professionals are listed, THE Sukoon App SHALL provide action buttons for Call, Book Online, and Chat
3. WHEN the User applies filters, THE Sukoon App SHALL show professionals matching the selected category (Counsellor, Psychiatrist, or Helpline)
4. WHEN the screen loads, THE Sukoon App SHALL display the message "Remember: Reaching out is a sign of strength 💪"
5. WHEN the User selects a professional, THE Sukoon App SHALL initiate the chosen communication method

### Requirement 8

**User Story:** As a user in crisis, I want immediate access to emergency help, so that I can get urgent support when needed.

#### Acceptance Criteria

1. WHEN the User opens the emergency help screen, THE Sukoon App SHALL display a prominent red SOS button
2. WHEN the SOS button is tapped, THE Sukoon App SHALL show emergency options including Call Emergency Contact, Share Location, and Mental Health Helpline Numbers
3. WHEN emergency contacts are displayed, THE Sukoon App SHALL show verified helpline numbers (AASRA, Snehi, etc.)
4. WHEN the User triggers an SOS Action, THE Sukoon App SHALL provide an auto-message option stating "I need help right now"
5. WHEN location sharing is selected, THE Sukoon App SHALL send the user's current location to the Emergency Contact

### Requirement 9

**User Story:** As a user tracking my progress, I want to see reports of my mental health journey, so that I can understand my improvement over time.

#### Acceptance Criteria

1. WHEN the User opens the reports screen, THE Sukoon App SHALL display a Mood Trend graph with weekly and monthly views
2. WHEN the reports screen loads, THE Sukoon App SHALL show the count of completed Self-Care Sessions
3. WHEN the User taps "Generate Report", THE Sukoon App SHALL create a PDF summary of mood and activity data
4. WHEN progress is calculated, THE Sukoon App SHALL display a progress line with percentage improvement
5. WHEN the report is generated, THE Sukoon App SHALL include encouraging messages like "You're healing — 40% improvement this month 💖"

### Requirement 10

**User Story:** As a user, I want to customize app settings and manage my privacy, so that I can control my experience and data.

#### Acceptance Criteria

1. WHEN the User opens settings, THE Sukoon App SHALL allow editing profile information and Emergency Contact details
2. WHEN the User toggles display mode, THE Sukoon App SHALL switch between Dark Mode and Light Mode
3. WHEN the User accesses privacy options, THE Sukoon App SHALL provide data deletion functionality
4. WHEN the User views "About Sukoon", THE Sukoon App SHALL display a message of hope and app information
5. WHEN settings are changed, THE Sukoon App SHALL persist preferences across app sessions

### Requirement 11

**User Story:** As a user, I want the app to have a calming visual design, so that the interface itself contributes to my sense of peace.

#### Acceptance Criteria

1. WHEN any screen renders, THE Sukoon App SHALL use calm gradient colors including sky blue, lavender, and pastel green
2. WHEN UI elements are displayed, THE Sukoon App SHALL use rounded cards and smooth transitions
3. WHEN icons are shown, THE Sukoon App SHALL use minimal, clear iconography
4. WHEN support messages appear, THE Sukoon App SHALL display heart-based animations
5. WHEN the User interacts with the app, THE Sukoon App SHALL provide gentle haptic feedback for chat replies and task completions
