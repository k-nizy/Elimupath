import 'user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  Future<UserEntity?> signInWithEmail(String email, String password);
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> register(String fullName, String email, String password, String role);
  Future<void> signOut();
  Future<void> sendPasswordReset(String email);
}
