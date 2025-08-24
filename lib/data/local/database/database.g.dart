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

  BagDao? _bagDaoInstance;

  FavoriteDao? _favoriteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `bag_entity` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `price` REAL NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT NOT NULL, `count` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorite_entity` (`productId` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT NOT NULL, `price` REAL NOT NULL, `count` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BagDao get bagDao {
    return _bagDaoInstance ??= _$BagDao(database, changeListener);
  }

  @override
  FavoriteDao get favoriteDao {
    return _favoriteDaoInstance ??= _$FavoriteDao(database, changeListener);
  }
}

class _$BagDao extends BagDao {
  _$BagDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bagEntityInsertionAdapter = InsertionAdapter(
            database,
            'bag_entity',
            (BagEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'count': item.count
                }),
        _bagEntityUpdateAdapter = UpdateAdapter(
            database,
            'bag_entity',
            ['id'],
            (BagEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'count': item.count
                }),
        _bagEntityDeletionAdapter = DeletionAdapter(
            database,
            'bag_entity',
            ['id'],
            (BagEntity item) => <String, Object?>{
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

  final InsertionAdapter<BagEntity> _bagEntityInsertionAdapter;

  final UpdateAdapter<BagEntity> _bagEntityUpdateAdapter;

  final DeletionAdapter<BagEntity> _bagEntityDeletionAdapter;

  @override
  Future<void> clearBag() async {
    await _queryAdapter.queryNoReturn('DELETE FROM bag_entity');
  }

  @override
  Future<BagEntity?> getBagItemById(int id) async {
    return _queryAdapter.query('SELECT * FROM bag_entity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BagEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            count: row['count'] as int),
        arguments: [id]);
  }

  @override
  Future<List<BagEntity>> getAllBagItems() async {
    return _queryAdapter.queryList('SELECT * FROM bag_entity',
        mapper: (Map<String, Object?> row) => BagEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            count: row['count'] as int));
  }

  @override
  Future<void> insertBagItem(BagEntity item) async {
    await _bagEntityInsertionAdapter.insert(item, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateBagItem(BagEntity item) async {
    await _bagEntityUpdateAdapter.update(item, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteBagItem(BagEntity item) async {
    await _bagEntityDeletionAdapter.delete(item);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteEntityInsertionAdapter = InsertionAdapter(
            database,
            'favorite_entity',
            (FavoriteEntity item) => <String, Object?>{
                  'productId': item.productId,
                  'title': item.title,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'price': item.price,
                  'count': item.count
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteEntity> _favoriteEntityInsertionAdapter;

  @override
  Future<List<FavoriteEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM favorite_entity',
        mapper: (Map<String, Object?> row) => FavoriteEntity(
            productId: row['productId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            price: row['price'] as double,
            count: row['count'] as int));
  }

  @override
  Future<FavoriteEntity?> getByProductId(int productId) async {
    return _queryAdapter.query(
        'SELECT * FROM favorite_entity WHERE productId = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => FavoriteEntity(
            productId: row['productId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            price: row['price'] as double,
            count: row['count'] as int),
        arguments: [productId]);
  }

  @override
  Future<void> deleteByProductId(int productId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM favorite_entity WHERE productId = ?1',
        arguments: [productId]);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM favorite_entity');
  }

  @override
  Future<void> insertItem(FavoriteEntity item) async {
    await _favoriteEntityInsertionAdapter.insert(
        item, OnConflictStrategy.replace);
  }
}
