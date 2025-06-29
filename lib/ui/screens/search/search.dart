import 'dart:convert';

import 'package:family_shop/model/product.dart';
import 'package:family_shop/ui/screens/detail/detail_screen.dart';
import 'package:family_shop/ui/screens/shoppingCart/shopping_cart.dart';
import 'package:family_shop/data/remote/shop_api.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: Icon(size: 30, Icons.arrow_back_ios)),
        ),
        title: Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCart(),
                  ),
                );
              },
              icon: Icon(size: 30, Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: " Search",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(height: 10),
            isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : filteredProducts.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ListTile(
                              leading: Image.network(
                                product.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                              title: Text(product.title),
                              subtitle: Text(product.category),
                              trailing: Text("\$${product.price}"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(product: product),
                                    ));
                              },
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text("No products found"),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  void fetchProducts() async {
    String? res = await ShopApi.GET("/products", {});
    List list = jsonDecode(res!);
    allProducts = list.map((e) => Product.fromJson(e)).toList();
    filteredProducts = allProducts;
    setState(() {
      isLoading = false;
    });
    }

  void filterSearchResults(String query) {
    List<Product> dummySearchList = [];
    dummySearchList.addAll(allProducts);
    if (query.isNotEmpty) {
      List<Product> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.category.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredProducts = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredProducts = allProducts;
      });
    }
  }
}
