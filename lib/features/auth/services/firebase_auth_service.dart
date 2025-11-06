import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile_model.dart';

/// Firebase Authentication Service
class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Check if user is logged in
  static bool get isLoggedIn => _auth.currentUser != null;

  // Auth state changes stream
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up with email and password
  static Future<User?> signUp({
    required String email,
    required String password,
    required UserProfileModel profile,
  }) async {
    try {
      // Create user in Firebase Auth
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        // Save profile to Firestore
        await saveUserProfile(user.uid, profile);

        // Update display name
        await user.updateDisplayName(profile.name);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Login with email and password
  static Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Logout
  static Future<void> logout() async {
    await _auth.signOut();
  }

  /// Save user profile to Firestore
  static Future<void> saveUserProfile(
    String uid,
    UserProfileModel profile,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': profile.name,
        'email': profile.email,
        'phone': profile.phone,
        'dateOfBirth': profile.dateOfBirth?.toIso8601String(),
        'age': profile.age,
        'gender': profile.gender,
        'profession': profile.profession,
        'address': profile.address,
        'emergencyContactName': profile.emergencyContactName,
        'emergencyContactRelation': profile.emergencyContactRelation,
        'emergencyContactPhone': profile.emergencyContactPhone,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save profile: $e');
    }
  }

  /// Get user profile from Firestore
  static Future<UserProfileModel?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      return UserProfileModel(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'],
        dateOfBirth: data['dateOfBirth'] != null
            ? DateTime.parse(data['dateOfBirth'])
            : null,
        gender: data['gender'],
        profession: data['profession'],
        address: data['address'],
        emergencyContactName: data['emergencyContactName'],
        emergencyContactRelation: data['emergencyContactRelation'],
        emergencyContactPhone: data['emergencyContactPhone'],
      );
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  /// Update user profile
  static Future<void> updateUserProfile(
    String uid,
    UserProfileModel profile,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'name': profile.name,
        'email': profile.email,
        'phone': profile.phone,
        'dateOfBirth': profile.dateOfBirth?.toIso8601String(),
        'age': profile.age,
        'gender': profile.gender,
        'profession': profile.profession,
        'address': profile.address,
        'emergencyContactName': profile.emergencyContactName,
        'emergencyContactRelation': profile.emergencyContactRelation,
        'emergencyContactPhone': profile.emergencyContactPhone,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  /// Send password reset email
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Handle Firebase Auth exceptions
  static String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
}
