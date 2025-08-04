import 'dart:async';

import 'package:floor/floor.dart';
import 'package:oila_market/data/local/dao/bag_dao.dart';
import 'package:oila_market/data/local/dao/favorite_dao.dart';
import 'package:oila_market/model/bag_entity.dart';
import 'package:oila_market/model/favorite_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version: 1, entities: [BagEntity, FavoriteEntity])
abstract class AppDatabase extends FloorDatabase {
  BagDao get bagDao;
  FavoriteDao get favoriteDao;
}
