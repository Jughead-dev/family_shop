import 'dart:convert';
import 'package:family_shop/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  Future<void> setBoolData(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBoolData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> saveProductList(String key, List<Product> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList = products
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await prefs.setStringList(key, encodedList);
  }

  Future<List<Product>> getProductList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList(key);
    if (encodedList == null) return [];
    return encodedList
        .map((item) => Product.fromJson(jsonDecode(item)))
        .toList();
  }
}
