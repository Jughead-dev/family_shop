import 'package:flutter/material.dart';
import 'package:family_shop/model/global_list.dart';
import 'package:family_shop/data/local/shared_prefs_service.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    _loadFavoriteList();
  }

  Future<void> _loadFavoriteList() async {
    final prefsService = SharedPrefsService();
    final loadedList = await prefsService.loadProductList('favoriteList');
    favoriteList
      ..clear()
      ..addAll(loadedList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(size: 30, Icons.arrow_back),
        ),
        title: Text("Your Favorites"),
        centerTitle: true,
      ),
      body: favoriteList.isEmpty
          ? Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final product = favoriteList[index];
                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price.toString()}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      favoriteList.removeAt(index);
                      await SharedPrefsService()
                          .saveProductList('favoriteList', favoriteList);
                      await SharedPrefsService()
                          .setBoolData('isLiked_${product.id}', false);
                      setState(() {});
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}