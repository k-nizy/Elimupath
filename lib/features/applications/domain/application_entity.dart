import 'package:equatable/equatable.dart';

class ApplicationEntity extends Equatable {
  final String id;
  final String studentId;
  final String schoolId;
  final String combination;
  final String previousSchool;
  final String status; // pending, accepted, rejected, withdrawn
  final DateTime submittedAt;
  final DateTime updatedAt;

  const ApplicationEntity({
    required this.id,
    required this.studentId,
    required this.schoolId,
    required this.combination,
    required this.previousSchool,
    required this.status,
    required this.submittedAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id, studentId, schoolId, combination, previousSchool,
        status, submittedAt, updatedAt,
      ];
}
