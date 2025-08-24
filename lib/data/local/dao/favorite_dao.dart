import 'package:floor/floor.dart';
import 'package:oila_market/model/favorite_entity.dart';


@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM favorite_entity')
  Future<List<FavoriteEntity>> getAll();

  @Query('SELECT * FROM favorite_entity WHERE productId = :productId LIMIT 1')
  Future<FavoriteEntity?> getByProductId(int productId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertItem(FavoriteEntity item);

  @Query('DELETE FROM favorite_entity WHERE productId = :productId')
  Future<void> deleteByProductId(int productId);

  @Query('DELETE FROM favorite_entity')
  Future<void> clear();
}
