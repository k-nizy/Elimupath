/// Failure base class for error handling across the app.
/// Every feature can extend this to create specific failures.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Thrown when a Firebase/server operation fails.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Thrown when there is no internet connection.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Thrown when Firebase Auth returns an error.
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Thrown when a Firestore document is not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
