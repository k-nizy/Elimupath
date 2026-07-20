import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/auth_repository.dart';
import '../../domain/user_entity.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<SignInWithEmailRequested>(_onSignInWithEmail);
    on<SignInWithGoogleRequested>(_onSignInWithGoogle);
    on<RegisterRequested>(_onRegister);
    on<SignOutRequested>(_onSignOut);
    on<PasswordResetRequested>(_onPasswordReset);
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  Future<void> _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    try {
      await emit.forEach<UserEntity?>(
        _authRepository.authStateChanges,
        onData: (user) {
          if (user == null) {
            return const Unauthenticated();
          }
          return Authenticated(user);
        },
      );
    } catch (e) {
      emit(AuthError('Failed to check auth status: ${e.toString()}'));
    }
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.signInWithEmail(
        event.email,
        event.password,
      );
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Sign in failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Google sign in failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.register(
        event.fullName,
        event.email,
        event.password,
        event.role,
      );
      if (user != null) {
        emit(EmailVerificationSent(
          'Registration successful! Please check your email to verify your account.',
        ));
      } else {
        emit(const AuthError('Registration failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onPasswordReset(
    PasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.sendPasswordReset(event.email);
      emit(PasswordResetSent('Password reset email sent to ${event.email}'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.isAuthenticated) {
      // The user is authenticated, state will be updated by authStateChanges stream
    } else {
      emit(const Unauthenticated());
    }
  }
}
