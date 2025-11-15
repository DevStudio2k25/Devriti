import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'core/constants/app_constants.dart';
// import 'core/constants/app_colors.dart'; // Not needed - using direct colors
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/localization/app_localizations.dart';
import 'shared/providers/theme_provider.dart';
import 'shared/providers/language_provider.dart';
import 'features/chat/models/message_model.dart';
// import 'features/mood/models/mood_entry_model.dart'; // Removed - mood tracker deleted
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable Firebase Auth persistence (keeps user logged in)
  // Note: setPersistence only works on web, mobile automatically persists
  try {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  } catch (e) {
    // Ignore on non-web platforms (mobile already persists by default)
    debugPrint('Auth persistence not needed on this platform: $e');
  }

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Hide system UI (status bar & navigation bar) - Immersive mode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize Hive for local storage (for chat data)
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(MessageModelAdapter());
  // Hive.registerAdapter(MoodEntryModelAdapter()); // Removed - mood tracker deleted

  runApp(const DevritiApp());
}

class DevritiApp extends StatefulWidget {
  const DevritiApp({super.key});

  @override
  State<DevritiApp> createState() => _DevritiAppState();
}

class _DevritiAppState extends State<DevritiApp> {
  late ThemeProvider _themeProvider;
  late LanguageProvider _languageProvider;

  @override
  void initState() {
    super.initState();
    _initializeProviders();
  }

  Future<void> _initializeProviders() async {
    _themeProvider = ThemeProvider();
    _languageProvider = LanguageProvider();

    // Initialize providers in background (no waiting)
    _themeProvider.init();
    _languageProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    // Directly show splash screen, no initial loading screen
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _themeProvider),
        ChangeNotifierProvider.value(value: _languageProvider),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: languageProvider.locale,
            supportedLocales: const [Locale('en'), Locale('hi')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: AppRouter.generateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
