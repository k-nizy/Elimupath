import 'package:equatable/equatable.dart';
import '../../domain/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String photoUrl;
  final String? schoolId;
  final bool emailVerified;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.photoUrl,
    this.schoolId,
    required this.emailVerified,
    required this.createdAt,
  });

  /// Convert from Firestore document
  factory UserModel.fromJson(Map<String, dynamic> json, String id, bool emailVerified) {
    return UserModel(
      id: id,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      schoolId: json['schoolId'] as String?,
      emailVerified: emailVerified,
      createdAt: (json['createdAt'] as dynamic).toDate(),
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'role': role,
      'photoUrl': photoUrl,
      'schoolId': schoolId,
      'createdAt': createdAt,
    };
  }

  /// Convert to domain entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      fullName: fullName,
      email: email,
      role: role,
      photoUrl: photoUrl,
      schoolId: schoolId,
      emailVerified: emailVerified,
      createdAt: createdAt,
    );
  }

  /// Convert from domain entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      role: entity.role,
      photoUrl: entity.photoUrl,
      schoolId: entity.schoolId,
      emailVerified: entity.emailVerified,
      createdAt: entity.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, fullName, email, role, photoUrl, schoolId, emailVerified, createdAt];
}
