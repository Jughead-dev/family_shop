import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_shop/model/product.dart';
import 'package:family_shop/ui/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:family_shop/data/local/shared_prefs_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Product> favoriteList = [];
  @override
  void initState() {
    super.initState();
    _loadFavoriteList();
  }

  Future<void> _loadFavoriteList() async {
    final prefsService = SharedPrefsService();
    favoriteList = await prefsService.getProductList('favoriteList');
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
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product.image,
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
                          builder: (_) => DetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
