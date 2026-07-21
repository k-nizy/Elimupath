import 'package:equatable/equatable.dart';
import '../../domain/application_entity.dart';

class ApplicationModel extends Equatable {
  final String id;
  final String studentId;
  final String schoolId;
  final String combination;
  final String previousSchool;
  final String status;
  final DateTime submittedAt;
  final DateTime updatedAt;

  const ApplicationModel({
    required this.id,
    required this.studentId,
    required this.schoolId,
    required this.combination,
    required this.previousSchool,
    required this.status,
    required this.submittedAt,
    required this.updatedAt,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json, String id) {
    return ApplicationModel(
      id: id,
      studentId: json['studentId'] as String,
      schoolId: json['schoolId'] as String,
      combination: json['combination'] as String,
      previousSchool: json['previousSchool'] as String,
      status: json['status'] as String,
      submittedAt: (json['submittedAt'] as dynamic).toDate(),
      updatedAt: (json['updatedAt'] as dynamic).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'schoolId': schoolId,
      'combination': combination,
      'previousSchool': previousSchool,
      'status': status,
      'submittedAt': submittedAt,
      'updatedAt': updatedAt,
    };
  }

  ApplicationEntity toEntity() {
    return ApplicationEntity(
      id: id,
      studentId: studentId,
      schoolId: schoolId,
      combination: combination,
      previousSchool: previousSchool,
      status: status,
      submittedAt: submittedAt,
      updatedAt: updatedAt,
    );
  }

  factory ApplicationModel.fromEntity(ApplicationEntity entity) {
    return ApplicationModel(
      id: entity.id,
      studentId: entity.studentId,
      schoolId: entity.schoolId,
      combination: entity.combination,
      previousSchool: entity.previousSchool,
      status: entity.status,
      submittedAt: entity.submittedAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        studentId,
        schoolId,
        combination,
        previousSchool,
        status,
        submittedAt,
        updatedAt,
      ];
}
