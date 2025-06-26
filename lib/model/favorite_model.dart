import 'package:family_shop/model/product.dart';
import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier {
  List<Product> favorites = [];

  void add(Product item) {
    if (!favorites.contains(item)) {
      favorites.add(item);
      notifyListeners();
    }
  }
    void remove(Product item) {
    favorites.remove(item);
    notifyListeners();
  }
}
