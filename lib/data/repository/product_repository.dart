import 'package:oila_market/data/local/dao/bag_dao.dart';
import 'package:oila_market/data/local/dao/favorite_dao.dart';
import 'package:oila_market/data/local/database/database_service.dart';
import 'package:oila_market/model/bag_entity.dart';
import 'package:oila_market/model/favorite_entity.dart';
import 'package:oila_market/model/product.dart';

class ProductRepository {
  // final BagDao  _bagDao = DatabaseService.database!.bagDao;
  // final FavoriteDao _favoriteDao = DatabaseService.database!.favoriteDao;

  ProductRepository();

  //Stream<List<BagEntity>> get allBagItems => _bagDao.getAllBagItems();
  //Stream<List<FavoriteEntity>> get allFavorites => _favoriteDao.getAllFavorites();

  Future<void> addToCart(Product product) async {
    // final existingItem = await _bagDao.getBagItemById(product.id!);
    
    // if (existingItem != null) {
    //   final updatedItem = existingItem.copyWith(count: existingItem.count + 1);
    //   await _bagDao.updateBagItem(updatedItem);
    // } else {
    //   await _bagDao.insertBagItem(_productToBagEntity(product));
    // }
  }

  Future<void> incrementCartItem(Product product) async {
    // final existingItem = await _bagDao.getBagItemById(product.id!);
    // if (existingItem != null) {
    //   final updatedItem = existingItem.copyWith(count: existingItem.count + 1);
    //   await _bagDao.updateBagItem(updatedItem);
    // }
  }

  Future<void> decrementCartItem(Product product) async {
    // final existingItem = await _bagDao.getBagItemById(product.id!);
    // if (existingItem != null) {
    //   if (existingItem.count > 1) {
    //     final updatedItem = existingItem.copyWith(count: existingItem.count - 1);
    //     await _bagDao.updateBagItem(updatedItem);
    //   } else {
    //     await _bagDao.deleteBagItem(existingItem.id as BagEntity);
    //   }
    // }
  }

  Future<void> toggleFavorite(Product product) async {
    // final existingFavorite = await _favoriteDao.getFavoriteItemById(product.id!);

    // if (existingFavorite != null) {
    //   await _favoriteDao.deleteFavoriteItem(product.id!);
    // } else {
    //   await _favoriteDao.insertFavoriteItem(_productToFavoriteEntity(product));
    // }
  }

 BagEntity _productToBagEntity(Product product) {
    return BagEntity(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      count: product.count,
    );
  }

  FavoriteEntity _productToFavoriteEntity(Product product) {
    return FavoriteEntity(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      count: product.count,
    );
  }
}
