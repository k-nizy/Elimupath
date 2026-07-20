import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class SignInWithEmailRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInWithEmailRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignInWithGoogleRequested extends AuthEvent {
  const SignInWithGoogleRequested();
}

class RegisterRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String role;

  const RegisterRequested({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [fullName, email, password, role];
}

class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

class PasswordResetRequested extends AuthEvent {
  final String email;

  const PasswordResetRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthStatusChanged extends AuthEvent {
  final bool isAuthenticated;
  final String? userRole;

  const AuthStatusChanged({
    required this.isAuthenticated,
    this.userRole,
  });

  @override
  List<Object?> get props => [isAuthenticated, userRole];
}
