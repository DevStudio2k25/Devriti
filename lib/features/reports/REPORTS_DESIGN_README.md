# 📊 Reports Page - Modern Neumorphic Design

## 🎨 Design Overview
A beautiful, modern reports page with **soft neumorphic dark UI**, 3D depth effects, and smooth animations. Perfect for mental health tracking and wellness insights.

## ✨ Key Features

### 1. **Neumorphic Design System**
- Soft dark background (#1A1D23)
- 3D depth with layered shadows
- Rounded corners (20px) everywhere
- Floating card effects
- Smooth gradients

### 2. **Animated Components**
- Fade-in page transition
- Scale animations on stat cards
- Animated progress ring (1.5s)
- Smooth chart transitions
- Staggered card animations

### 3. **Interactive Elements**
- Period selector (Week/Month/Year)
- Glowing active states
- Smooth hover effects
- Haptic feedback ready

### 4. **Data Visualization**
- Circular progress ring with gradient
- Line chart for mood trends
- Bar chart for mood distribution
- Color-coded mood stats
- Real-time data updates

## 📱 Page Sections

### Header
- Neumorphic back button
- App icon with title
- Smooth scroll behavior

### Stats Grid (3 Cards)
- Improvement percentage
- Total tracking days
- Average mood score
- Animated entrance
- Color-coded icons

### Period Selector
- Week/Month/Year tabs
- Smooth tab switching
- Gradient active state
- Glowing effect

### Progress Card
- Large circular ring (180px)
- Animated progress (0-100%)
- Gradient ring (Mint → Blue → Purple)
- Outer glow effect
- Motivational message

### Mood Trend Chart
- 7-day line chart
- Gradient line
- Smooth curves
- Dot indicators
- Area fill effect

### Mood Distribution
- 5 mood emoji stats
- Neumorphic emoji containers
- Gradient bar chart
- Color-coded bars
- Interactive tooltips

### Insights Card
- Most common mood
- Best day analysis
- Peak time detection
- Icon-based insights
- Color-coded items

### Action Buttons
- Generate PDF report
- Share functionality
- Export data
- Gradient buttons
- Glow effects

## 🎨 Color Palette

```dart
Background: #1A1D23
Card: #2A2F38
Text Primary: #E8EDF3
Text Secondary: #9BA5B4
Text Tertiary: #6D737A

Accents:
- Purple: #8B7FFF → #B8A8FF
- Mint: #7FDFB1
- Blue: #7FB8FF
- Orange: #FFB88C
- Coral: #FF9B9B
```

## 🚀 Usage

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ReportsScreen(),
  ),
);
```

## 📊 Data Integration

The page automatically:
- Loads mood entries from repository
- Calculates statistics
- Generates insights
- Animates on data load
- Handles empty states

## 🎯 Empty State

When no data available:
- Large neumorphic icon
- Friendly message
- Call-to-action text
- Centered layout

## 💡 Design Principles

1. **Soft & Calm**: Easy on the eyes
2. **3D Depth**: Tactile, premium feel
3. **Smooth Animations**: Delightful interactions
4. **Clear Hierarchy**: Easy to scan
5. **Data-Driven**: Meaningful insights

---

**Created with ❤️ for DEVRITI Mental Health App**
