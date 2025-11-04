import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final user = UserModel(
          id: credential.user!.uid,
          email: credential.user!.email,
          name: credential.user!.displayName,
          isGuest: false,
          createdAt: DateTime.now(),
          photoUrl: credential.user!.photoURL,
        );
        await _authRepository.saveUser(user);
        return user;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> signUpWithEmail(
    String email,
    String password, {
    String? name,
    String? ageGroup,
    String? emergencyContact,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        if (name != null) {
          await credential.user!.updateDisplayName(name);
        }

        final user = UserModel(
          id: credential.user!.uid,
          email: credential.user!.email,
          name: name ?? credential.user!.displayName,
          ageGroup: ageGroup,
          emergencyContact: emergencyContact,
          isGuest: false,
          createdAt: DateTime.now(),
          photoUrl: credential.user!.photoURL,
        );
        await _authRepository.saveUser(user);
        return user;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        final user = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email,
          name: userCredential.user!.displayName,
          isGuest: false,
          createdAt: DateTime.now(),
          photoUrl: userCredential.user!.photoURL,
        );
        await _authRepository.saveUser(user);
        return user;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> continueAsGuest() async {
    final user = UserModel(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Guest',
      isGuest: true,
      createdAt: DateTime.now(),
    );
    await _authRepository.saveUser(user);
    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await _authRepository.deleteUser();
  }

  UserModel? getCurrentUser() {
    return _authRepository.getCurrentUser();
  }
}
