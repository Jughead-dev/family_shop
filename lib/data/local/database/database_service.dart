
import 'package:oila_market/data/local/database/database.dart';

class DatabaseService {
  static AppDatabase? _database;
  static AppDatabase? database = _database;
  static initialize() async {
    _database ??= await $FloorAppDatabase
        .databaseBuilder("app_database.db")
        .build();
  }
}
