// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  LikeDao? _likeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `product_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `price` REAL NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT NOT NULL, `count` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `like_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `productId` INTEGER NOT NULL, `isLiked` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  LikeDao get likeDao {
    return _likeDaoInstance ??= _$LikeDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'product_table',
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'count': item.count
                }),
        _productDeletionAdapter = DeletionAdapter(
            database,
            'product_table',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'count': item.count
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final DeletionAdapter<Product> _productDeletionAdapter;

  @override
  Future<Product?> getProductById(int id) async {
    return _queryAdapter.query('SELECT * FROM product_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int?,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            count: row['count'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Product>> getAllProduct() async {
    return _queryAdapter.queryList('SELECT * FROM product_table',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int?,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            count: row['count'] as int));
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM product_table');
  }

  @override
  Future<void> saveProduct(Product product) async {
    await _productInsertionAdapter.insert(product, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteProduct(Product product) async {
    await _productDeletionAdapter.delete(product);
  }
}

class _$LikeDao extends LikeDao {
  _$LikeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _likeInsertionAdapter = InsertionAdapter(
            database,
            'like_table',
            (Like item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'isLiked': item.isLiked ? 1 : 0
                }),
        _likeDeletionAdapter = DeletionAdapter(
            database,
            'like_table',
            ['id'],
            (Like item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'isLiked': item.isLiked ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Like> _likeInsertionAdapter;

  final DeletionAdapter<Like> _likeDeletionAdapter;

  @override
  Future<Like?> getLikeByProductId(int productId) async {
    return _queryAdapter.query(
        'SELECT * FROM like_table WHERE productId = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => Like(
            id: row['id'] as int,
            productId: row['productId'] as int,
            isLiked: (row['isLiked'] as int) != 0),
        arguments: [productId]);
  }

  @override
  Future<List<Like>> getAllLikes() async {
    return _queryAdapter.queryList('SELECT * FROM like_table',
        mapper: (Map<String, Object?> row) => Like(
            id: row['id'] as int,
            productId: row['productId'] as int,
            isLiked: (row['isLiked'] as int) != 0));
  }

  @override
  Future<void> saveLike(Like like) async {
    await _likeInsertionAdapter.insert(like, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteLike(Like like) async {
    await _likeDeletionAdapter.delete(like);
  }
}
