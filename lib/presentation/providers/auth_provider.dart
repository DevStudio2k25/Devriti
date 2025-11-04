import 'package:flutter/material.dart';

/// Provider for managing authentication state
class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isGuest = false;
  String? _userId;
  String? _userName;

  bool get isAuthenticated => _isAuthenticated;
  bool get isGuest => _isGuest;
  String? get userId => _userId;
  String? get userName => _userName;

  /// Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    // TODO: Implement actual authentication
    _isAuthenticated = true;
    _isGuest = false;
    _userId = 'user_123';
    _userName = email.split('@')[0];
    notifyListeners();
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    // TODO: Implement Google sign-in
    _isAuthenticated = true;
    _isGuest = false;
    _userId = 'google_user_123';
    _userName = 'Google User';
    notifyListeners();
  }

  /// Continue as guest
  Future<void> continueAsGuest() async {
    _isAuthenticated = true;
    _isGuest = true;
    _userId = 'guest_${DateTime.now().millisecondsSinceEpoch}';
    _userName = 'Guest';
    notifyListeners();
  }

  /// Sign out
  Future<void> signOut() async {
    _isAuthenticated = false;
    _isGuest = false;
    _userId = null;
    _userName = null;
    notifyListeners();
  }

  /// Update user name
  void updateUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
