import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String role; // student, parent, schoolAdmin
  final String photoUrl;
  final String? schoolId;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.photoUrl,
    this.schoolId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, fullName, email, role, photoUrl, schoolId, createdAt];
}
