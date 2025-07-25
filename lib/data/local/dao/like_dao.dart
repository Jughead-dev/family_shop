import 'package:floor/floor.dart';
import 'package:oila_market/model/like.dart';

@dao
abstract class LikeDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveLike(Like like);

  @Query('SELECT * FROM like_table WHERE productId = :productId LIMIT 1')
  Future<Like?> getLikeByProductId(int productId);

  @Query('SELECT * FROM like_table')
  Future<List<Like>> getAllLikes();

  @delete
  Future<void> deleteLike(Like like);
}
