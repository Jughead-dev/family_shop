import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/bag_bloc/bag_cubit.dart';
import 'package:oila_market/bloc/bag_bloc/bag_state.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BagCubit>(context).loadBagItems();
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
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 30),
          ),
        ),
        title: const Text("Your Bag"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                final cubit = context.read<BagCubit>();
                if (cubit.state.bagList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("siz xali buyurtma bermadingiz"),
                      showCloseIcon: true,
                    ),
                  );
                } else {
                  BlocProvider.of<BagCubit>(context).clearBag();
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text("barcha mahsulotlar o'chirildi"),
                        showCloseIcon: true,
                      ),
                    );
                }
              },
              icon: const Icon(Icons.delete, size: 30),
            ),
          ),
        ],
      ),
      body: BlocBuilder<BagCubit, BagState>(builder: (context, state) {
        final cartItems = state.bagList;
        if (cartItems.isEmpty) {
          return const Center(child: Text("Your cart is empty"));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Items: ${context.read<BagCubit>().getTotalItems()}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Total Price: \$${context.read<BagCubit>().getTotalPrice().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = state.bagList[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              height: 100,
                              width: 100,
                              imageUrl: product.image,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  product.category,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$${product.price.toString()}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<BagCubit>(context)
                                            .removeFromBag(product);
                                      },
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      color: Colors.red,
                                    ),
                                    Text(
                                      product.count.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<BagCubit>(context)
                                            .addToBag(product);
                                      },
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Total: \$${product.price.toString()}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    final cubit = context.read<BagCubit>();
                    if (cubit.state.bagList.isNotEmpty) {
                      cubit.clearBag();
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.info, color: Colors.white),
                                SizedBox(width: 10),
                                Text("mahsulotlar tez orada yetkaziladi"),
                              ],
                            ),
                            showCloseIcon: true,
                          ),
                        );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    "PLACING AN ORDER",
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
