import '../../domain/favorite_repository.dart';
import '../../domain/favorite_entity.dart';

/// Firestore implementation of FavoriteRepository.
/// TODO (Olga): Implement actual Firestore operations
class FavoriteRepositoryImpl implements FavoriteRepository {
  @override
  Stream<List<FavoriteEntity>> getUserFavorites(String userId) {
    // TODO (Olga): Implement Firestore query for user's favorites
    throw UnimplementedError('FavoriteRepositoryImpl.getUserFavorites not implemented');
  }

  @override
  Future<void> addFavorite(FavoriteEntity favorite) {
    // TODO (Olga): Implement Firestore document creation
    throw UnimplementedError('FavoriteRepositoryImpl.addFavorite not implemented');
  }

  @override
  Future<void> removeFavorite(String favoriteId) {
    // TODO (Olga): Implement Firestore document deletion
    throw UnimplementedError('FavoriteRepositoryImpl.removeFavorite not implemented');
  }
}
