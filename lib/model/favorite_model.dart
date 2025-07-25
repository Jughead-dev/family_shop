import 'package:flutter/foundation.dart';
import 'package:oila_market/data/local/dao/like_dao.dart';
import 'package:oila_market/model/like.dart';
import 'package:oila_market/model/product.dart';

class FavoriteModel extends ChangeNotifier {
  final LikeDao likeDao;
  final List<Product> _favorites = [];

  FavoriteModel({required this.likeDao});

  List<Product> get favorites => _favorites;
  Future<void> toggleFavorite(Product product) async {
    final like = await likeDao.getLikeByProductId(product.id!);

    if (like != null && like.isLiked) {
      await likeDao.saveLike(Like(
          id: like.id, productId: product.id!, isLiked: false)); // Remove like
      _favorites.remove(product);
    } else {
      await likeDao.saveLike(
          Like(id: 0, productId: product.id!, isLiked: true)); // Add like
      _favorites.add(product);
    }

    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.contains(product);
  }
}
