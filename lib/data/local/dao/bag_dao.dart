import 'package:floor/floor.dart';
import 'package:oila_market/model/bag_entity.dart';

@dao
abstract class BagDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveBag(BagEntity bag);

  @Query('SELECT * FROM bag_entity WHERE id = :id')
  Future<BagEntity?> getBagById(int id);
  @Query("SELECT * FROM bag_entity")
  Future<List<BagEntity>> getAllBag();

  @Query('DELETE FROM bag_entity')
  Future<void> clear();

  @delete
  Future<void> deleteBag(BagEntity bag);
}
