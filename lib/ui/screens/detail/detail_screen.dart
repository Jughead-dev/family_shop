import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oila_market/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:oila_market/bloc/favorite_bloc/favorite_state.dart';
import 'package:oila_market/config/app_colors.dart';
import 'package:oila_market/model/product.dart';
import 'package:oila_market/ui/screens/shoppingCart/shopping_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/bag_bloc/bag_cubit.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 30),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShoppingCart()),
              );
            },
            icon: const Icon(Icons.shopping_bag_outlined, size: 30),
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 12),
              CachedNetworkImage(
                imageUrl: product.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "\$${product.price}",
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        final isFav = context.read<FavoriteCubit>().isFavorite(product); ;
                        return IconButton(
                          onPressed: () {
                            context.read<FavoriteCubit>().toggleFavorite(product);
                          },
                          icon: isFav
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border, color: Colors.black),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Text(
                product.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                product.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 112),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<BagCubit>().addToBag(product, onAdded: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.info),
                                Text("Mahsulot qo'shildi"),
                              ],
                            ),
                            showCloseIcon: true,
                          ),
                        );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ShoppingCart()),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    "ADD TO BAG",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
