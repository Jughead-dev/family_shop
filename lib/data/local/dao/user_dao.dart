import 'package:floor/floor.dart';
import 'package:oila_market/model/user.dart';

@dao
abstract class UserDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveUser(User user);

  @Query('SELECT * FROM user_table WHERE id = :id')
  Future<User?> getUserById(int id);
  @Query("SELECT * FROM user_table")
  Future<List<User>> getAllUser();

  @Query('DELETE FROM user_table')
  Future<void> clear();

  @delete
  Future<void> deleteUser(User user);
}
