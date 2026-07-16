import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final String id;
  final String userId;
  final String schoolId;
  final DateTime addedAt;

  const FavoriteEntity({
    required this.id,
    required this.userId,
    required this.schoolId,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [id, userId, schoolId, addedAt];
}
