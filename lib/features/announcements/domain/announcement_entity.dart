import 'package:equatable/equatable.dart';

class AnnouncementEntity extends Equatable {
  final String id;
  final String schoolId;
  final String title;
  final String body;
  final DateTime postedAt;
  final String postedBy;

  const AnnouncementEntity({
    required this.id,
    required this.schoolId,
    required this.title,
    required this.body,
    required this.postedAt,
    required this.postedBy,
  });

  @override
  List<Object?> get props => [id, schoolId, title, body, postedAt, postedBy];
}
