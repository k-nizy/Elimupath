import 'package:equatable/equatable.dart';
import '../../domain/announcement_entity.dart';

class AnnouncementModel extends Equatable {
  final String id;
  final String schoolId;
  final String title;
  final String body;
  final DateTime postedAt;
  final String postedBy;

  const AnnouncementModel({
    required this.id,
    required this.schoolId,
    required this.title,
    required this.body,
    required this.postedAt,
    required this.postedBy,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json, String id) {
    return AnnouncementModel(
      id: id,
      schoolId: json['schoolId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      postedAt: (json['postedAt'] as dynamic).toDate(),
      postedBy: json['postedBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolId': schoolId,
      'title': title,
      'body': body,
      'postedAt': postedAt,
      'postedBy': postedBy,
    };
  }

  AnnouncementEntity toEntity() {
    return AnnouncementEntity(
      id: id,
      schoolId: schoolId,
      title: title,
      body: body,
      postedAt: postedAt,
      postedBy: postedBy,
    );
  }

  factory AnnouncementModel.fromEntity(AnnouncementEntity entity) {
    return AnnouncementModel(
      id: entity.id,
      schoolId: entity.schoolId,
      title: entity.title,
      body: entity.body,
      postedAt: entity.postedAt,
      postedBy: entity.postedBy,
    );
  }

  @override
  List<Object?> get props => [id, schoolId, title, body, postedAt, postedBy];
}
