# 🎨 DEVRITI Mental Health App - Complete UI Design Prompt

## 📱 App Overview
Create a modern mental health and wellness Flutter app with **soft neumorphic dark UI design** featuring 3D depth effects, smooth rounded corners, and a calm, fluffy aesthetic. The app should feel premium, peaceful, and therapeutic.

---

## 🎯 Core Design System

### Color Palette (Soft Dark Theme)
```
Primary Background: #1A1D23 (Soft dark blue-gray)
Secondary Background: #252932 (Slightly lighter dark)
Card Background: #2A2F38 (Elevated surface)
Accent Colors:
  - Calm Purple: #8B7FFF (Primary actions)
  - Soft Coral: #FF9B9B (Alerts/Heart rate)
  - Mint Green: #7FDFB1 (Success/Positive)
  - Warm Orange: #FFB88C (Progress/Energy)
  - Sky Blue: #7FB8FF (Info/Calm)
  - Lavender: #B8A8FF (Secondary)

Text Colors:
  - Primary Text: #E8EDF3 (Soft white)
  - Secondary Text: #9BA5B4 (Muted gray)
  - Tertiary Text: #6D737A (Subtle gray)

Shadows & Depth:
  - Inner Shadow: rgba(0, 0, 0, 0.6) with offset (4, 4)
  - Outer Highlight: rgba(255, 255, 255, 0.03) with offset (-4, -4)
  - Glow Effects: Use accent colors with 0.3-0.6 opacity
```

### Typography
```
Font Family: Inter / SF Pro / Gilroy
Headings: 24-32px, Weight 600-700
Body: 14-16px, Weight 400-500
Captions: 12-14px, Weight 300-400
Numbers/Stats: 40-80px, Weight 300 (thin for elegance)
```

### Design Principles
1. **Neumorphic 3D Depth**: All cards should have layered shadows (inner dark + outer light)
2. **Soft Rounded Corners**: 16-24px border radius for cards, 12-16px for buttons
3. **Floating Elements**: Cards should appear to float above background
4. **Glowing Accents**: Progress rings, active states use soft glows
5. **Generous Spacing**: 16-24px padding, 12-16px gaps between elements
6. **Smooth Gradients**: Use subtle gradients for depth (not harsh)
7. **Icon Style**: Outlined icons with 2px stroke, 24-28px size
8. **Glassmorphism**: Subtle blur effects on overlays

---

## 📄 Page 1: HOME PAGE

### Layout Structure
```
AppBar (Floating, Neumorphic):
  - Left: Avatar (48px, neumorphic circle)
  - Center: "Good Morning, [Name]" (greeting based on time)
  - Right: Notification bell with badge (neumorphic)
  - Background: Slightly elevated card with shadow
  - Height: 80px with padding

Main Content (ScrollView):
  1. Daily Mood Check Card (Hero Section)
  2. Health Stats Grid (2x2)
  3. Quick Actions Row
  4. Today's Activities List
  5. Motivational Quote Card
```

### 1. Daily Mood Check Card (Neumorphic Hero)
```
Design:
  - Large card (full width, 200px height)
  - Neumorphic depth with inner/outer shadows
  - Rounded corners: 24px
  - Background: Gradient (#2A2F38 → #252932)
  
Content:
  - Title: "How are you feeling today?" (18px, #E8EDF3)
  - 5 Mood Emojis in a row (48px each, neumorphic circles)
    😊 Happy | 😌 Calm | 😐 Neutral | 😟 Anxious | 😢 Sad
  - Selected mood has glowing ring (accent color)
  - Subtitle: "Tap to log your mood" (12px, #9BA5B4)
  
Interaction:
  - Tap emoji → Glow animation + haptic feedback
  - Smooth scale animation on press
```

### 2. Health Stats Grid (2x2 Neumorphic Cards)
```
Grid Layout: 2 columns, 2 rows, 12px gap

Card 1 - Heart Rate (Star-shaped like reference):
  - Star-shaped neumorphic container (150x150)
  - Center: Large number "72" (48px, #E8EDF3)
  - Below: "bpm" (12px, #6D737A)
  - Glowing orange progress ring (75% complete)
  - Top: Small red heart icon with glow
  - Corner icons: Steps, Calories, Sleep, Water (neumorphic circles)
  
Card 2 - Mood Score:
  - Rounded square (150x150, 24px radius)
  - Neumorphic depth
  - Center: "85%" (48px, #8B7FFF)
  - Progress ring in purple gradient
  - Icon: Smiling face emoji
  - Label: "Mood Score" (14px)
  
Card 3 - Sleep Quality:
  - Same style as Card 2
  - Center: "7.5h" (48px, #7FB8FF)
  - Moon icon with stars
  - Progress ring in blue
  - Label: "Sleep Quality"
  
Card 4 - Stress Level:
  - Same style
  - Center: "Low" (32px, #7FDFB1)
  - Zen icon (meditation pose)
  - Progress ring in mint green
  - Label: "Stress Level"
```

### 3. Quick Actions Row (Horizontal Scroll)
```
Design:
  - Horizontal scrollable row
  - Each action: Neumorphic pill button (120x60)
  - Rounded: 16px
  - Icon + Text layout
  
Actions:
  1. 🧘 "Meditate" (Purple glow)
  2. 💬 "AI Chat" (Coral glow)
  3. 📝 "Journal" (Orange glow)
  4. 🎵 "Sounds" (Blue glow)
  5. 📊 "Reports" (Lavender glow)
  
Interaction:
  - Tap → Glow intensifies + navigate
  - Smooth horizontal scroll
```

### 4. Today's Activities (List)
```
Section Header:
  - "Today's Activities" (20px, bold)
  - "See All" button (right aligned, 14px, purple)
  
Activity Cards (Neumorphic):
  - Each card: 60px height, full width
  - Left: Icon in neumorphic circle (40px)
  - Center: Title + Time (14px + 12px)
  - Right: Checkmark or arrow
  - 8px gap between cards
  
Examples:
  - 🧘 Morning Meditation | 8:00 AM | ✓ Completed
  - 💊 Take Medication | 10:00 AM | → Pending
  - 🚶 Evening Walk | 6:00 PM | → Upcoming
```

### 5. Motivational Quote Card
```
Design:
  - Full width card, 120px height
  - Neumorphic with soft gradient background
  - Rounded: 20px
  
Content:
  - Quote icon (top-left, 24px, purple)
  - Quote text: "Every day is a new beginning..." (16px, italic)
  - Author: "- Unknown" (12px, right-aligned)
  - Soft glow around edges
```

---

## 📄 Page 2: PROFILE PAGE

### Layout Structure
```
Header Section (Fixed):
  - Cover gradient (120px height)
  - Avatar (100px, centered, neumorphic)
  - Name + Edit button
  
Content Sections:
  1. Personal Stats Cards
  2. Achievements Grid
  3. Settings List
  4. Danger Zone
```

### 1. Header Section
```
Design:
  - Gradient background (#8B7FFF → #B8A8FF)
  - Avatar: Large neumorphic circle (100px)
  - Positioned: -50px from bottom (overlapping)
  - White border: 4px
  - Edit icon: Small neumorphic button (32px, bottom-right of avatar)
  
Content:
  - Name: "John Doe" (24px, bold, centered)
  - Subtitle: "Member since Jan 2024" (14px, muted)
  - Edit Profile button (neumorphic, 40px height)
```

### 2. Personal Stats Cards (3 Cards Row)
```
Layout: 3 equal cards, horizontal

Card 1 - Streak:
  - Neumorphic square (100x100)
  - Icon: 🔥 Fire (32px)
  - Number: "15" (36px, orange)
  - Label: "Day Streak" (12px)
  
Card 2 - Sessions:
  - Icon: 🧘 Meditation (32px)
  - Number: "48" (36px, purple)
  - Label: "Sessions" (12px)
  
Card 3 - Journals:
  - Icon: 📝 Journal (32px)
  - Number: "23" (36px, mint)
  - Label: "Entries" (12px)
```

### 3. Achievements Grid (2x3)
```
Section Header: "Achievements" (20px, bold)

Achievement Badges (Neumorphic):
  - Each: 80x80 rounded square
  - Unlocked: Full color with glow
  - Locked: Grayscale with lock icon
  
Examples:
  - 🏆 "7 Day Streak" (Gold glow)
  - 🌟 "First Journal" (Purple glow)
  - 💪 "Mood Master" (Mint glow)
  - 🎯 "Consistency King" (Orange glow)
  - 🧘 "Zen Master" (Blue glow)
  - 🔒 "30 Day Streak" (Locked)
```

### 4. Settings List (Neumorphic Cards)
```
Each Setting Item:
  - Neumorphic card (60px height)
  - Left: Icon in circle (40px)
  - Center: Title + Subtitle
  - Right: Arrow or Toggle
  - 8px gap between items
  
Items:
  1. 👤 Account Settings → Arrow
  2. 🔔 Notifications → Toggle (ON)
  3. 🌙 Dark Mode → Toggle (ON)
  4. 🔒 Privacy → Arrow
  5. 📊 Data & Storage → Arrow
  6. 💬 Help & Support → Arrow
  7. ℹ️ About App → Arrow
```

### 5. Danger Zone
```
Design:
  - Red-tinted neumorphic card
  - Rounded: 16px
  - Subtle red glow
  
Content:
  - ⚠️ "Danger Zone" (16px, red)
  - "Delete Account" button (neumorphic, red accent)
  - "Logout" button (neumorphic, coral)
```

---

## 📄 Page 3: DOCTOR PAGE

### Layout Structure
```
Header:
  - Search bar (neumorphic)
  - Filter chips row
  
Content:
  1. Featured Doctor Card (Hero)
  2. Specialization Grid
  3. Doctor List (Scrollable)
  4. Floating Book Appointment Button
```

### 1. Search & Filters
```
Search Bar:
  - Neumorphic input (50px height)
  - Rounded: 16px
  - Icon: 🔍 (left)
  - Placeholder: "Search doctors..."
  - Voice icon (right)
  
Filter Chips (Horizontal Scroll):
  - Neumorphic pills (40px height)
  - Selected: Glowing accent color
  - Unselected: Subtle depth
  
Chips:
  - 🧠 Psychologist
  - 💊 Psychiatrist
  - 🩺 Therapist
  - ❤️ Counselor
  - ⭐ Top Rated
```

### 2. Featured Doctor Card (Hero)
```
Design:
  - Large neumorphic card (full width, 180px)
  - Gradient background (#8B7FFF → #B8A8FF)
  - Rounded: 24px
  - Soft glow around edges
  
Content:
  - Left: Doctor photo (80px circle, white border)
  - Right Content:
    - Name: "Dr. Sarah Johnson" (20px, bold)
    - Specialization: "Clinical Psychologist" (14px)
    - Rating: ⭐ 4.9 (120 reviews)
    - Badge: "Available Now" (green glow)
  - Bottom: "Book Appointment" button (neumorphic, white)
```

### 3. Specialization Grid (2x2)
```
Each Card:
  - Neumorphic square (160x120)
  - Rounded: 20px
  - Icon: 64px (top)
  - Label: 16px (bottom)
  - Count: "24 doctors" (12px, muted)
  
Specializations:
  1. 🧠 Psychology (Purple glow)
  2. 💊 Psychiatry (Coral glow)
  3. 🩺 Therapy (Mint glow)
  4. ❤️ Counseling (Orange glow)
```

### 4. Doctor List Cards
```
Each Doctor Card:
  - Neumorphic card (full width, 100px)
  - Rounded: 20px
  - 12px gap between cards
  
Layout:
  - Left: Photo (70px circle)
  - Center:
    - Name (16px, bold)
    - Specialization (14px, muted)
    - Experience: "8 years" (12px)
    - Rating: ⭐ 4.8 (14px)
  - Right:
    - Availability dot (green/red)
    - Price: "$50/session" (14px)
    - Arrow icon
  
Interaction:
  - Tap → Navigate to doctor details
  - Favorite icon (top-right, neumorphic)
```

### 5. Floating Action Button
```
Design:
  - Large neumorphic circle (64px)
  - Bottom-right corner (16px margin)
  - Purple gradient with glow
  - Icon: 📅 Calendar (32px, white)
  
Interaction:
  - Tap → Open booking modal
  - Pulse animation (subtle)
```

---

## 📄 Page 4: EMERGENCY PAGE

### Layout Structure
```
Header:
  - Warning banner (animated)
  - Emergency status indicator
  
Content:
  1. SOS Button (Hero)
  2. Quick Actions Grid
  3. Emergency Contacts List
  4. Helpline Numbers
  5. Crisis Resources
```

### 1. Warning Banner
```
Design:
  - Full width, 60px height
  - Red gradient with pulse animation
  - Rounded top corners: 20px
  
Content:
  - ⚠️ Icon (animated)
  - "Emergency Support Available 24/7"
  - Pulse effect (subtle)
```

### 2. SOS Button (Hero)
```
Design:
  - Large neumorphic circle (200px)
  - Center of screen
  - Red gradient (#FF3B3B → #E51A1A)
  - Multiple shadow layers for 3D depth
  - Pulsing glow animation (red, 0.6 opacity)
  
Content:
  - "SOS" text (48px, bold, white)
  - "Press & Hold" (14px, below)
  - Ripple effect on press
  
Interaction:
  - Press & hold 3 seconds → Trigger emergency
  - Progress ring appears during hold
  - Haptic feedback + sound
```

### 3. Quick Actions Grid (2x2)
```
Each Action Card:
  - Neumorphic square (160x140)
  - Rounded: 20px
  - Icon: 48px (top)
  - Title: 16px (center)
  - Subtitle: 12px (bottom)
  - Accent color glow
  
Actions:
  1. 📞 "Call Friend" (Mint glow)
     - "Reach out to someone"
  
  2. 🫁 "Breathing Exercise" (Blue glow)
     - "Calm yourself now"
  
  3. 🎵 "Calming Sounds" (Purple glow)
     - "Soothing audio"
  
  4. 💬 "Crisis Chat" (Coral glow)
     - "Talk to AI support"
```

### 4. Emergency Contacts List
```
Section Header:
  - "Emergency Contacts" (20px, bold)
  - "+ Add Contact" (right, purple)
  
Contact Cards:
  - Neumorphic card (80px height)
  - Left: Avatar (50px circle)
  - Center:
    - Name (16px, bold)
    - Relationship (14px, muted)
    - Phone number (12px)
  - Right:
    - Call button (neumorphic circle, green)
    - Message button (neumorphic circle, blue)
  
Examples:
  - 👤 John Doe | Father | +1 234-567-8900
  - 👤 Jane Smith | Best Friend | +1 234-567-8901
```

### 5. Helpline Numbers
```
Section Header: "Crisis Helplines" (20px, bold)

Helpline Cards:
  - Neumorphic card (100px height)
  - Left: Icon (40px, neumorphic circle)
  - Center:
    - Organization name (16px, bold)
    - Number (20px, purple, bold)
    - Description (12px, muted)
    - "Available 24/7" badge (green)
  - Right: Call button (neumorphic, green glow)
  
Examples:
  1. 🆘 National Suicide Prevention
     - 988
     - "24/7 Crisis Support"
  
  2. 💬 Crisis Text Line
     - Text "HELLO" to 741741
     - "Free 24/7 text support"
  
  3. 🧠 Mental Health Hotline
     - 1-800-662-4357
     - "Treatment referral"
```

---

## 📄 Page 5: SELF CARE PAGE

### Layout Structure
```
Header:
  - Greeting + Streak counter
  - Daily goal progress
  
Content:
  1. Breathing Exercise Card (Hero)
  2. Activity Categories Grid
  3. Recommended Activities
  4. Journal Entry Card
  5. Mood Tracker
```

### 1. Header Section
```
Design:
  - Gradient background (Purple → Lavender)
  - Rounded bottom: 32px
  - Height: 140px
  
Content:
  - "Self Care" title (28px, bold, white)
  - Streak: "🔥 15 Day Streak" (16px)
  - Daily Goal Progress Bar:
    - "3/5 activities completed today"
    - Neumorphic progress bar (rounded, glowing)
    - 60% filled (mint green)
```

### 2. Breathing Exercise Card (Hero)
```
Design:
  - Large neumorphic card (full width, 280px)
  - Rounded: 24px
  - Dark gradient background
  - Center: Animated breathing circle
  
Content:
  - Title: "Breathing Exercise" (20px, top)
  - Animated Circle (150px):
    - Neumorphic depth
    - Pulsing animation (expand/contract)
    - Gradient fill (Blue → Purple)
    - Soft glow effect
  - Instructions: "Breathe In... Hold... Breathe Out..." (16px)
  - Timer: "4:00" (24px, center)
  - Start/Stop button (neumorphic, bottom)
  
Animation:
  - Circle expands (4 sec) → Hold (4 sec) → Contracts (4 sec)
  - Text changes with animation
  - Smooth easing curves
```

### 3. Activity Categories Grid (2x3)
```
Each Category Card:
  - Neumorphic square (160x140)
  - Rounded: 20px
  - Icon: 48px (top)
  - Title: 16px (center)
  - Count: "12 activities" (12px, bottom)
  - Accent color glow
  
Categories:
  1. 🧘 "Meditation" (Purple glow)
  2. 🎵 "Sounds" (Blue glow)
  3. 📝 "Journaling" (Orange glow)
  4. 🎨 "Art Therapy" (Coral glow)
  5. 🚶 "Movement" (Mint glow)
  6. 📚 "Reading" (Lavender glow)
```

### 4. Recommended Activities List
```
Section Header:
  - "Recommended for You" (20px, bold)
  - "View All" (right, purple)
  
Activity Cards:
  - Neumorphic card (120px height)
  - Rounded: 20px
  - 12px gap between cards
  
Layout:
  - Left: Thumbnail image (100x100, rounded 16px)
  - Right Content:
    - Title (16px, bold)
    - Category badge (neumorphic pill)
    - Duration: "10 min" (14px)
    - Difficulty: "Beginner" (12px, muted)
    - Rating: ⭐ 4.8 (14px)
  - Play button (neumorphic circle, overlay on image)
  
Examples:
  1. 🧘 "Morning Meditation"
     - Category: Meditation
     - 10 min | Beginner
  
  2. 🎵 "Ocean Waves"
     - Category: Sounds
     - 15 min | All Levels
  
  3. 📝 "Gratitude Journal"
     - Category: Journaling
     - 5 min | Beginner
```

### 5. Quick Journal Entry Card
```
Design:
  - Neumorphic card (full width, 160px)
  - Rounded: 20px
  - Gradient background (subtle)
  
Content:
  - Icon: 📝 (32px, top-left)
  - Title: "Quick Journal Entry" (18px, bold)
  - Input field (neumorphic inset):
    - Placeholder: "How are you feeling right now?"
    - Multi-line (3 rows)
    - Rounded: 12px
  - Save button (neumorphic, purple, bottom-right)
  
Interaction:
  - Tap input → Expand to full screen editor
  - Auto-save on blur
```

### 6. Mood Tracker Section
```
Section Header: "This Week's Mood" (20px, bold)

Mood Chart Card:
  - Neumorphic card (full width, 200px)
  - Rounded: 20px
  
Content:
  - Line chart (7 days):
    - X-axis: Mon-Sun
    - Y-axis: Mood levels (1-5)
    - Line: Gradient (Purple → Mint)
    - Points: Neumorphic circles with glow
    - Current day highlighted
  - Average mood: "😊 4.2/5" (16px, center-bottom)
  - Trend indicator: "↗️ Improving" (14px, green)
```

---

## 🎨 Common UI Components

### Bottom Navigation Bar
```
Design:
  - Neumorphic bar (70px height)
  - Rounded top corners: 24px
  - Floating above content (8px margin)
  - Soft shadow underneath
  
Items (5):
  1. 🏠 Home
  2. 👨‍⚕️ Doctors
  3. 🆘 Emergency (larger, elevated)
  4. 🧘 Self Care
  5. 👤 Profile
  
Active State:
  - Icon: Glowing accent color
  - Label: Bold, accent color
  - Neumorphic highlight behind icon
  
Inactive State:
  - Icon: Muted gray
  - Label: Light gray
  - No highlight
```

### Loading States
```
Skeleton Loader:
  - Neumorphic cards with shimmer effect
  - Gradient animation (left to right)
  - Rounded corners match actual content
  - Pulse animation (subtle)
```

### Empty States
```
Design:
  - Center of screen
  - Large icon (80px, muted)
  - Title (20px, bold)
  - Subtitle (14px, muted)
  - Action button (neumorphic)
  
Example:
  - 📭 "No messages yet"
  - "Start a conversation to see messages here"
  - [Start Chat] button
```

### Modals & Dialogs
```
Design:
  - Neumorphic card (centered)
  - Rounded: 24px
  - Backdrop: Blur + dark overlay (0.6 opacity)
  - Slide-up animation
  
Content:
  - Icon (48px, top)
  - Title (20px, bold)
  - Message (14px, muted)
  - Action buttons (neumorphic, horizontal)
  
Example:
  - ⚠️ "Confirm Action"
  - "Are you sure you want to continue?"
  - [Cancel] [Confirm]
```

---

## 🎭 Animations & Interactions

### Micro-interactions
```
1. Button Press:
   - Scale down to 0.95
   - Increase shadow depth
   - Haptic feedback
   - Duration: 150ms

2. Card Tap:
   - Subtle scale (0.98)
   - Glow intensifies
   - Duration: 200ms

3. Toggle Switch:
   - Smooth slide animation
   - Color transition
   - Duration: 300ms

4. Progress Rings:
   - Animate from 0 to value
   - Easing: easeOutCubic
   - Duration: 1500ms

5. Page Transitions:
   - Fade + Slide
   - Duration: 400ms
   - Curve: easeInOutCubic
```

### Loading Animations
```
1. Circular Progress:
   - Neumorphic ring
   - Gradient rotation
   - Smooth infinite loop

2. Pulse Effect:
   - Scale 1.0 → 1.1 → 1.0
   - Opacity 1.0 → 0.6 → 1.0
   - Duration: 2000ms

3. Shimmer Effect:
   - Gradient sweep (left to right)
   - For skeleton loaders
   - Duration: 1500ms
```

---

## 📐 Spacing & Layout Guidelines

### Padding & Margins
```
Screen Padding: 16-20px
Card Padding: 16-20px
Section Spacing: 24-32px
Element Spacing: 12-16px
Tight Spacing: 8px
```

### Grid System
```
Columns: 12-column grid
Gutter: 12px
Container Max Width: 600px (mobile)
Breakpoints:
  - Mobile: < 600px
  - Tablet: 600-900px
  - Desktop: > 900px
```

---

## 🎯 Accessibility Features

### Must Include
```
1. High contrast text (WCAG AA compliant)
2. Touch targets: Minimum 44x44px
3. Screen reader support (semantic labels)
4. Keyboard navigation support
5. Focus indicators (glowing outline)
6. Alternative text for images
7. Haptic feedback for important actions
8. Voice control support
9. Adjustable text sizes
10. Color-blind friendly palette
```

---

## 🚀 Implementation Notes

### Flutter Packages to Use
```
1. flutter_neumorphic: For neumorphic effects
2. shimmer: For loading animations
3. flutter_animate: For micro-interactions
4. glassmorphism: For blur effects
5. fl_chart: For mood charts
6. lottie: For complex animations
7. cached_network_image: For images
8. flutter_svg: For vector icons
```

### Performance Optimization
```
1. Use const constructors where possible
2. Implement lazy loading for lists
3. Cache images and data
4. Optimize shadow rendering
5. Use RepaintBoundary for complex widgets
6. Implement pagination for long lists
7. Debounce search inputs
8. Use Hero animations for transitions
```

---

## ✅ Final Checklist

### Before Implementation
- [ ] Review color palette with team
- [ ] Confirm icon set (outlined style)
- [ ] Prepare image assets (2x, 3x)
- [ ] Set up design tokens
- [ ] Create component library
- [ ] Test on multiple devices
- [ ] Validate accessibility
- [ ] Performance testing
- [ ] User testing feedback
- [ ] Final polish pass

---

## 🎨 Design Philosophy Summary

**"Soft, Calm, Therapeutic"**

This UI should feel like a warm hug - comforting, safe, and peaceful. Every interaction should be smooth and satisfying. The neumorphic depth creates a tactile, almost physical feeling that makes the app feel premium and carefully crafted. The soft dark theme is easy on the eyes while maintaining excellent readability. Rounded corners and generous spacing create a fluffy, approachable aesthetic that reduces anxiety and promotes calm.

**Key Feelings to Evoke:**
- 🕊️ Peace & Calm
- 🛡️ Safety & Security  
- 💎 Premium & Polished
- 🤗 Warm & Welcoming
- 🎯 Clear & Focused

---

**End of Design Prompt** 🎨✨
