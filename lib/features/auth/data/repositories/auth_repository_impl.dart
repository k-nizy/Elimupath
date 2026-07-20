import '../../domain/auth_repository.dart';
import '../../domain/user_entity.dart';
import '../datasources/firebase_auth_datasource.dart';
import '../../../../core/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Stream<UserEntity?> get authStateChanges => _datasource.authStateChanges;

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    try {
      return await _datasource.signInWithEmail(email, password);
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw AuthFailure('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    try {
      return await _datasource.signInWithGoogle();
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw AuthFailure('Failed to sign in with Google: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> register(
    String fullName,
    String email,
    String password,
    String role,
  ) async {
    try {
      return await _datasource.register(fullName, email, password, role);
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw AuthFailure('Failed to register: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _datasource.signOut();
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw AuthFailure('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await _datasource.passwordReset(email);
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw AuthFailure('Failed to send password reset: ${e.toString()}');
    }
  }
}
