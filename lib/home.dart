import 'dart:convert';
import 'package:family_shop/model/product.dart';
import 'package:family_shop/model/user.dart';
import 'package:family_shop/pages/product_item.dart';
import 'package:family_shop/pages/search.dart';
import 'package:family_shop/pages/shopping_cart.dart';
import 'package:family_shop/pages/profile_page.dart';
import 'package:family_shop/shop_api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Men's Clothing", "value": "men's clothing"},
    {"label": "Women's Clothing", "value": "women's clothing"},
    {"label": "Jewelry", "value": "jewelery"},
    {"label": "Electronics", "value": "electronics"},
  ];
  String selectedCategory = "All";

  List<Product> products = [];
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProduct();
    getUser();
  }

  void getProduct() async {
    String? res = await ShopApi.GET("/products", {});
    List list = jsonDecode(res!);
    products = list.map((e) => Product.fromJson(e)).toList();
    setState(() {
      isLoading = false;
    });
  }

  void getUser() async {
    String? res = await ShopApi.GET("/users", {});
    List list = jsonDecode(res!);
    users = list.map((a) => User.fromJson(a)).toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        user: users.first,
                      )),
            );
          },
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/logo.webp"),
          ),
        ),
        title: Text(
          "Oila Market",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search(),
                  ),
                );
              },
              icon: Icon(Icons.content_paste_search_outlined),
            ),
          ),
          SizedBox(width: 7),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCart(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          ),
          SizedBox(width: 9),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi Don"),
                      SizedBox(height: 4),
                      Text(
                        "What are you looking for\n today?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categories.map((category) {
                            bool isSelected =
                                selectedCategory == category['value'];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category['value']!;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected ? Colors.black : Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  category['label']!,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    final filteredProducts = selectedCategory == "All"
                        ? products
                        : products
                            .where((p) => p.category == selectedCategory)
                            .toList();
                    return GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: filteredProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductItem(product: product),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  product.image,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "\$${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
    );
  }
}
