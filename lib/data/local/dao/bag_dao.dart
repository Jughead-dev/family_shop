import 'package:floor/floor.dart';
import 'package:oila_market/model/bag_entity.dart';

@dao
abstract class BagDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBagItem(BagEntity item);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBagItem(BagEntity item);

  @delete
  Future<void> deleteBagItem(BagEntity item);

  @Query('SELECT * FROM bag_entity WHERE id = :id')
  Future<BagEntity?> getBagItemById(int id);

  @Query('SELECT * FROM bag_entity')
  Future<List<BagEntity>> getAllBagItems();
}
