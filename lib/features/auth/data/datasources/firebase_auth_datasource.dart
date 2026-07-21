import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/user_entity.dart';
import '../models/user_model.dart';
import '../../../../core/errors/failures.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthDatasource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return _mapFirebaseUserToEntity(user);
    });
  }

  Future<UserEntity?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _getUserEntity(credential.user);
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  Future<UserEntity?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthFailure('Google sign-in was cancelled');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      // Check if user document exists, if not create one
      final userDoc = await _firestore.collection('users').doc(userCredential.user?.uid).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'fullName': userCredential.user?.displayName ?? 'User',
          'email': userCredential.user?.email ?? '',
          'role': 'student', // Default role for Google sign-in
          'photoUrl': userCredential.user?.photoURL ?? '',
          'schoolId': null,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return await _getUserEntity(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  Future<UserEntity?> register(
    String fullName,
    String email,
    String password,
    String role,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await credential.user?.sendEmailVerification();

      // Create user document in Firestore
      final userModel = UserModel(
        id: credential.user!.uid,
        fullName: fullName,
        email: email,
        role: role,
        photoUrl: '',
        schoolId: role == 'schoolAdmin' ? null : null, // Will be set for school admins later
        emailVerified: credential.user!.emailVerified,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userModel.toJson());

      return userModel.toEntity();
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  Future<void> passwordReset(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw AuthFailure('Failed to sign out: ${e.toString()}');
    }
  }

  Future<UserEntity?> _getUserEntity(User? user) async {
    if (user == null) return null;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      return _mapFirebaseUserToEntity(user);
    }

    final userModel = UserModel.fromJson(userDoc.data()!, user.uid, user.emailVerified);
    return userModel.toEntity();
  }

  UserEntity _mapFirebaseUserToEntity(User user) {
    return UserEntity(
      id: user.uid,
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      role: 'student', // Default if not in Firestore yet
      photoUrl: user.photoURL ?? '',
      schoolId: null,
      emailVerified: user.emailVerified,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  Failure _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthFailure('No user found with this email.');
      case 'wrong-password':
        return const AuthFailure('Incorrect password.');
      case 'email-already-in-use':
        return const AuthFailure('This email is already registered.');
      case 'invalid-email':
        return const AuthFailure('Invalid email address.');
      case 'weak-password':
        return const AuthFailure('Password is too weak. Use at least 8 characters.');
      case 'user-disabled':
        return const AuthFailure('This account has been disabled.');
      case 'too-many-requests':
        return const AuthFailure('Too many attempts. Please try again later.');
      case 'operation-not-allowed':
        return const AuthFailure('Email/password accounts are not enabled.');
      default:
        return AuthFailure('Authentication error: ${e.message}');
    }
  }
}
