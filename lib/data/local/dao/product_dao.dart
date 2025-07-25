import 'package:floor/floor.dart';
import 'package:oila_market/model/product.dart';

@dao
abstract class ProductDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveProduct(Product product);

  @Query('SELECT * FROM product_table WHERE id = :id')
  Future<Product?> getProductById(int id);
  @Query("SELECT * FROM product_table")
  Future<List<Product>> getAllProduct();

  @Query('DELETE FROM product_table')
  Future<void> clear();

  @delete
  Future<void> deleteProduct(Product product);
}
