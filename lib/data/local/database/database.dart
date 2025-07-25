import 'dart:async';

import 'package:floor/floor.dart';
import 'package:oila_market/data/local/dao/like_dao.dart';
import 'package:oila_market/data/local/dao/product_dao.dart';
import 'package:oila_market/model/like.dart';
import 'package:oila_market/model/product.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version: 1, entities: [Product, Like])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
  LikeDao get likeDao;
}
