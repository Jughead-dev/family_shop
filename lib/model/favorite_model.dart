import 'package:flutter/material.dart';

import 'product.dart';



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
