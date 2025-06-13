import 'package:http/http.dart';

class ShopApi {
   static String BASE_URL = "fakestoreapi.com";
  static Map<String, String> headers = {
    "Content-type": "application/json; charset=UTF-8",
  };

  /* Http apis */
  static const String PRODUCTS_LIST = "/products";

  /* Http requests */
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    final uri = Uri.https(BASE_URL, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
}