import 'favorite_entity.dart';

abstract class FavoriteRepository {
  Stream<List<FavoriteEntity>> getUserFavorites(String userId);
  Future<void> addFavorite(FavoriteEntity favorite);
  Future<void> removeFavorite(String favoriteId);
}
