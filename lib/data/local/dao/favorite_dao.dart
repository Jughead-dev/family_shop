import 'package:floor/floor.dart';
import 'package:oila_market/model/favorite_entity.dart';
@dao
abstract class FavoriteDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoriteItem(FavoriteEntity item);

  @Query('DELETE FROM favorite_entity WHERE id = :id')
  Future<void> deleteFavoriteItem(int id);

  @Query('SELECT * FROM favorite_entity WHERE id = :id')
  Future<FavoriteEntity?> getFavoriteItemById(int id);
  
  @Query('SELECT * FROM favorite_entity')
  Stream<List<FavoriteEntity>> getAllFavorites();
}
