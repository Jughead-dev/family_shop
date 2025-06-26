import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:family_shop/model/favorite_model.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteModel>().favorites;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(size: 30, Icons.arrow_back),
        ),
        title: Text("Your Favorites"),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.network(product.image,
                      width: 50, height: 50, fit: BoxFit.contain),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price.toString()}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<FavoriteModel>().remove(product);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(product: product),
                        ));
                  },
                );
              },
            ),
    );
  }
}
