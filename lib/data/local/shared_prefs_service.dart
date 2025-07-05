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
    if (products.isEmpty) {
      await prefs.remove(key);
      return;
    }
    List<String> encodedList =
        products.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(key, encodedList);
  }

  Future<void> saveIntList(String key, List<int> intList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = intList.map((e) => e.toString()).toList();
    await prefs.setStringList(key, stringList);
  }

  Future<List<int>> getIntList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList(key);
    if (stringList == null) return [];
    return stringList.map((e) => int.tryParse(e) ?? 0).toList();
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
