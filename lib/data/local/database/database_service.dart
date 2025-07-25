import 'package:oila_market/data/local/dao/like_dao.dart';
import 'package:oila_market/data/local/database/database.dart';
import 'package:oila_market/model/like.dart';

class DatabaseService {
  static AppDatabase? _database;

  // Database ni initialize qilish
  static Future<void> initialize() async {
    if (_database == null) {
      // AppDatabase-ni yaratish
      _database = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    }
  }

  // LikeDao'ni olish
  static Future<LikeDao> getLikeDao() async {
    final db = await _database;
    return db!.likeDao;
  }

  // Like saqlash
  static Future<void> saveLike(Like like) async {
    final db = await _database;
    await db?.likeDao.saveLike(like);  // Like saqlash
  }

  // Barcha like-larni olish
  static Future<List<Like>> getAllLikes() async {
    final db = await _database;
    return await db?.likeDao.getAllLikes() ?? [];  // Barcha like'larni olish
  }

  // Mahsulot ID bo'yicha like-larni olish
  static Future<Object> getLikesByProductId(int productId) async {
    final db = await _database;
    return await db?.likeDao.getLikeByProductId(productId) ?? [];  // Mahsulotga oid like'larni olish
  }

  // Like o'chirish
  static Future<void> deleteLike(Like like) async {
    final db = await _database;
    await db?.likeDao.deleteLike(like);  // Like o'chirish
  }
}
