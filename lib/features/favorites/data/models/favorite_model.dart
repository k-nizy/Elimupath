import 'package:equatable/equatable.dart';
import '../../domain/favorite_entity.dart';

class FavoriteModel extends Equatable {
  final String id;
  final String userId;
  final String schoolId;
  final DateTime addedAt;

  const FavoriteModel({
    required this.id,
    required this.userId,
    required this.schoolId,
    required this.addedAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json, String id) {
    return FavoriteModel(
      id: id,
      userId: json['userId'] as String,
      schoolId: json['schoolId'] as String,
      addedAt: (json['addedAt'] as dynamic).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'schoolId': schoolId,
      'addedAt': addedAt,
    };
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      userId: userId,
      schoolId: schoolId,
      addedAt: addedAt,
    );
  }

  factory FavoriteModel.fromEntity(FavoriteEntity entity) {
    return FavoriteModel(
      id: entity.id,
      userId: entity.userId,
      schoolId: entity.schoolId,
      addedAt: entity.addedAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, schoolId, addedAt];
}
