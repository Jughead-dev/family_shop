import 'package:floor/floor.dart';
import 'package:oila_market/model/favorite_entity.dart';

@dao
abstract class FavoriteDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveProduct(FavoriteEntity favorite);

  @Query('SELECT * FROM favorites WHERE id = :id')
  Future<FavoriteEntity?> getFavoriteById(int id);
  @Query("SELECT * FROM favorites")
  Future<List<FavoriteEntity>> getAllFavorite();

  @Query('DELETE FROM favorites')
  Future<void> clear();

  @delete
  Future<void> deleteFavorite(FavoriteEntity favorite);
}
