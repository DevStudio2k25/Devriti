# Notification System Implementation Guide

**Developer Documentation - Local Notifications (No Firebase)**

---

## 1. Overview

This guide explains how to implement local notifications in the DEVRITI Flutter app without using Firebase Cloud Messaging (FCM).

**Why Local Notifications?**
- No server or cloud dependency required
- Works completely offline
- Perfect for routine reminders and AI-based suggestions
- Lightweight and privacy-focused
- No backend infrastructure needed

**What This Covers:**
- Daily routine reminders
- AI-driven notification suggestions
- Scheduled notifications based on user mood/activity
- All notifications run locally on the device

---

## 2. Required Package

**Package:** `flutter_local_notifications`

**Version:** ^17.0.0 (or latest stable)

**Why This Plugin?**
- Most popular and well-maintained local notification plugin
- Supports Android and iOS
- Handles scheduled notifications natively
- Works when app is closed or in background
- No Firebase dependency
- Timezone support built-in

**Add to `pubspec.yaml`:**
```yaml
dependencies:
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.2  # Required for scheduling
```

---

## 3. Initialization Setup

### Step 1: Initialize in `main.dart`

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize timezone
  tz.initializeTimeZones();
  
  // Initialize notifications
  await initializeNotifications();
  
  runApp(const DevritiApp());
}

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onNotificationTap,
  );
}

void onNotificationTap(NotificationResponse response) {
  // Handle notification tap
  // Navigate to specific screen based on payload
  print('Notification tapped: ${response.payload}');
}
```

### Step 2: Android Permissions

**Add to `android/app/src/main/AndroidManifest.xml`:**

```xml
<manifest>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

    <application>
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
            </intent-filter>
        </receiver>
    </application>
</manifest>
```

### Step 3: iOS Considerations

**For iOS, request permissions explicitly:**

```dart
Future<void> requestIOSPermissions() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}
```

---

## 4. Scheduling Notifications

### Daily Notification

```dart
Future<void> scheduleDailyReminder({
  required int id,
  required String title,
  required String body,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    _nextInstanceOfTime(time),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_reminder_channel',
        'Daily Reminders',
        channelDescription: 'Daily routine and wellness reminders',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );
  
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  
  return scheduledDate;
}
```

### Routine-Based Notification

```dart
Future<void> scheduleRoutineReminder({
  required int routineId,
  required String routineTitle,
  required DateTime scheduledTime,
}) async {
  final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(
    scheduledTime,
    tz.local,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    routineId,
    'Routine Reminder',
    'Time for: $routineTitle',
    tzScheduledTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'routine_channel',
        'Routine Reminders',
        channelDescription: 'Reminders for daily routines',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    payload: 'routine_$routineId',
  );
}
```

### AI-Based Suggestion Notification

```dart
Future<void> scheduleAINotification({
  required int id,
  required String aiMessage,
  required Duration delay,
}) async {
  final tz.TZDateTime scheduledTime = tz.TZDateTime.now(tz.local).add(delay);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    'DEVRITI AI',
    aiMessage,
    scheduledTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'ai_suggestions_channel',
        'AI Suggestions',
        channelDescription: 'AI-powered wellness suggestions',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(''),
      ),
      iOS: DarwinNotificationDetails(),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    payload: 'ai_suggestion',
  );
}
```

### Converting DateTime to TZDateTime

```dart
tz.TZDateTime convertToTZDateTime(DateTime dateTime) {
  return tz.TZDateTime.from(dateTime, tz.local);
}

// Example usage:
final scheduledTime = DateTime.now().add(Duration(hours: 2));
final tzTime = convertToTZDateTime(scheduledTime);
```

### How Notifications Work When App is Closed

- Scheduled notifications are registered with the OS
- OS handles triggering at the scheduled time
- No need for app to be running
- Notifications persist even after device restart (if BOOT_COMPLETED permission granted)

---

## 5. Managing Notifications

### Cancel Specific Notification

```dart
Future<void> cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}
```

### Cancel All Notifications

```dart
Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}
```

### Re-schedule When Routine is Edited

```dart
Future<void> updateRoutineNotification({
  required int routineId,
  required String newTitle,
  required DateTime newTime,
}) async {
  // Cancel old notification
  await cancelNotification(routineId);
  
  // Schedule new notification
  await scheduleRoutineReminder(
    routineId: routineId,
    routineTitle: newTitle,
    scheduledTime: newTime,
  );
}
```

### Tips for Notification IDs

**Best Practices:**
- Use unique ID per routine (e.g., routine's database ID)
- Use consistent ID ranges:
  - 1-1000: Daily reminders
  - 1001-5000: Routine reminders
  - 5001-10000: AI suggestions
- Store IDs in database with routines
- Never reuse IDs for different notification types

**Example ID Management:**

```dart
class NotificationIds {
  static const int dailyMorningReminder = 1;
  static const int dailyEveningReminder = 2;
  
  static int routineId(int routineDbId) => 1000 + routineDbId;
  static int aiSuggestion(int index) => 5000 + index;
}
```

---

## 6. AI-Driven Notification Logic (Without Firebase)

### How It Works

1. **AI Analyzes User State:**
   - User chats with AI
   - AI detects mood (sad, anxious, stressed)
   - AI generates helpful suggestion

2. **Developer Schedules Local Notification:**
   - Based on AI output, schedule notification locally
   - No server or Firebase needed
   - Notification triggers at scheduled time

3. **Example Flow:**

```
User: "I'm feeling really anxious today"
    ↓
AI detects: Anxiety
    ↓
AI suggests: "Try breathing exercises"
    ↓
Developer schedules notification:
  - 2 hours later: "Hey, take a moment to breathe 🫁"
    ↓
Notification triggers automatically
```

### Implementation Example

```dart
Future<void> handleAISuggestion({
  required String userMessage,
  required String aiResponse,
  required String detectedEmotion,
}) async {
  // AI detected user needs support
  if (detectedEmotion == 'anxious' || detectedEmotion == 'stressed') {
    // Schedule follow-up notification
    await scheduleAINotification(
      id: NotificationIds.aiSuggestion(1),
      aiMessage: 'Remember to take deep breaths. You got this! 💙',
      delay: Duration(hours: 2),
    );
  }
  
  if (detectedEmotion == 'sad' || detectedEmotion == 'depressed') {
    await scheduleAINotification(
      id: NotificationIds.aiSuggestion(2),
      aiMessage: 'You\'re not alone. I\'m here for you 🌸',
      delay: Duration(hours: 3),
    );
  }
}
```

### AI Suggestion Triggers

**When to Schedule:**
- After detecting negative emotions
- When user hasn't opened app for 24 hours
- After completing a routine (positive reinforcement)
- Based on time of day (morning motivation, evening calm)

**Message Examples:**
- "Time for your morning meditation 🧘"
- "Don't forget to hydrate! 💧"
- "You did great today! Rest well 🌙"
- "Feeling stressed? Try a quick breathing exercise 🫁"

---

## 7. Background Behavior

### How Scheduled Notifications Work in Background

**Key Points:**
- Notifications are scheduled with the OS, not the app
- OS triggers notifications at exact time
- App doesn't need to be running
- No background service required
- No Firebase or server needed

**What Happens:**
1. App schedules notification with OS
2. App can be closed/killed
3. OS keeps notification in queue
4. At scheduled time, OS shows notification
5. User taps → App opens with payload

**Limitations:**
- Cannot dynamically change notification content after scheduling
- Cannot fetch data from server before showing
- Must re-schedule after device restart (handled by BOOT_COMPLETED receiver)

---

## 8. Example Code Snippets

### Initialize Notifications

```dart
Future<void> init() async {
  tz.initializeTimeZones();
  
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  
  const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  
  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );
  
  await flutterLocalNotificationsPlugin.initialize(settings);
}
```

### Schedule Daily Reminder

```dart
Future<void> scheduleDailyReminder() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    1,
    'Daily Check-in',
    'How are you feeling today? 💙',
    _nextInstanceOfTime(TimeOfDay(hour: 9, minute: 0)),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel',
        'Daily Reminders',
        importance: Importance.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}
```

### Schedule Routine Reminder

```dart
Future<void> scheduleRoutineReminder(int id, String title, DateTime time) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    'Routine Reminder',
    title,
    tz.TZDateTime.from(time, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'routine_channel',
        'Routines',
        importance: Importance.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
```

### Schedule AI Notification

```dart
Future<void> scheduleAINotification(String message, Duration delay) async {
  final scheduledTime = tz.TZDateTime.now(tz.local).add(delay);
  
  await flutterLocalNotificationsPlugin.zonedSchedule(
    5001,
    'DEVRITI AI',
    message,
    scheduledTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'ai_channel',
        'AI Suggestions',
        importance: Importance.high,
        styleInformation: BigTextStyleInformation(''),
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
```

### Cancel Notification

```dart
Future<void> cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}
```

---

## 9. Common Issues + Fixes

### Issue 1: Notification Didn't Fire

**Possible Causes:**
- Time already passed
- Timezone not initialized
- Permission not granted
- Wrong schedule mode

**Fix:**
```dart
// Always check if time is in future
if (scheduledTime.isBefore(DateTime.now())) {
  scheduledTime = scheduledTime.add(Duration(days: 1));
}

// Initialize timezone in main()
tz.initializeTimeZones();

// Use exactAllowWhileIdle for Android 12+
androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
```

### Issue 2: Permission Problems

**Android 13+ requires runtime permission:**

```dart
Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    
    await androidImplementation?.requestNotificationsPermission();
  }
}
```

### Issue 3: Timezone Issues

**Problem:** Notification fires at wrong time

**Fix:**
```dart
// Always use tz.local
tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // Set your timezone

// Convert DateTime properly
final tzTime = tz.TZDateTime.from(dateTime, tz.local);
```

### Issue 4: App Restart Scheduling

**Problem:** Notifications lost after app restart

**Fix:**
- BOOT_COMPLETED receiver handles this automatically
- Optionally, re-schedule on app launch:

```dart
Future<void> reScheduleAllNotifications() async {
  // Fetch all routines from database
  final routines = await getRoutinesFromDB();
  
  // Re-schedule each
  for (var routine in routines) {
    await scheduleRoutineReminder(
      routine.id,
      routine.title,
      routine.scheduledTime,
    );
  }
}
```

---

## 10. Best Practices

### Use Unique Notification IDs

```dart
// Bad
await scheduleNotification(1, 'Message 1');
await scheduleNotification(1, 'Message 2'); // Overwrites first

// Good
await scheduleNotification(1001, 'Routine 1');
await scheduleNotification(1002, 'Routine 2');
```

### Don't Over-Notify

**Guidelines:**
- Max 3-5 notifications per day
- Space them out (minimum 2 hours apart)
- Allow user to disable specific types
- Respect quiet hours (10 PM - 7 AM)

```dart
bool isQuietHours() {
  final hour = DateTime.now().hour;
  return hour >= 22 || hour < 7;
}

Future<void> scheduleIfNotQuietHours(/* params */) async {
  if (!isQuietHours()) {
    await scheduleNotification(/* params */);
  }
}
```

### Keep Messages Short & Positive

**Good Examples:**
- "Time for your morning walk! 🚶"
- "You're doing great! Keep it up 💪"
- "Remember to breathe 🫁"

**Bad Examples:**
- "You haven't completed your routine. Complete it now or you'll fail."
- "Your mental health is getting worse. Do something about it."

### Sync with Routine Updates

**When user edits routine:**
1. Cancel old notification
2. Schedule new notification
3. Update database

```dart
Future<void> updateRoutine(Routine routine) async {
  // Cancel old
  await cancelNotification(routine.id);
  
  // Update DB
  await database.updateRoutine(routine);
  
  // Schedule new
  await scheduleRoutineReminder(
    routine.id,
    routine.title,
    routine.scheduledTime,
  );
}
```

### Store Notification State

```dart
class NotificationPreferences {
  bool dailyRemindersEnabled = true;
  bool routineRemindersEnabled = true;
  bool aiSuggestionsEnabled = true;
  
  TimeOfDay quietHoursStart = TimeOfDay(hour: 22, minute: 0);
  TimeOfDay quietHoursEnd = TimeOfDay(hour: 7, minute: 0);
}
```

---

## Summary

**Key Takeaways:**
- Use `flutter_local_notifications` for all notifications
- No Firebase or server required
- Notifications work offline and in background
- Schedule based on AI suggestions locally
- Always use unique IDs
- Handle permissions properly
- Test on real devices (not just emulator)

**Next Steps:**
1. Add package to pubspec.yaml
2. Initialize in main.dart
3. Add Android permissions
4. Implement scheduling functions
5. Test on physical device
6. Integrate with AI logic

---

**End of Documentation**
