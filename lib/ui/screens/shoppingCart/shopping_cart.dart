import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_shop/model/product.dart';
import 'package:family_shop/data/local/shared_prefs_service.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  Map<Product, int> cartItems = {};

  @override
  void initState() {
    super.initState();
   // _loadBag();
  }

  // Future<void> _loadBag() async {
  //   final loadedBag = await SharedPrefsService().loadProductList('bagList');
  //   bag
  //     ..clear()
  //     ..addAll(loadedBag);
  //   cartItems.clear();
  //   for (var i in bag) {
  //     cartItems[i] = (cartItems[i] ?? 0) + 1;
  //   }
  //   setState(() {});
  // }

  // Future<void> _saveBag() async {
  //   // cartItems ni bag ro‘yxatiga aylantirib saqlash
  //   bag.clear();
  //   cartItems.forEach((product, quantity) {
  //     for (int i = 0; i < quantity; i++) {
  //       bag.add(product);
  //     }
  //   });
  //   await SharedPrefsService().saveProductList('bagList', bag);
  // }

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
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems.keys.elementAt(index);
                      final quantity = cartItems[product]!;
                      final totalPrice = product.price * quantity;

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
                                  fit: BoxFit.cover,
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
                                      "\$${product.price.toStringAsFixed(2)} each",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (quantity > 1) {
                                                cartItems[product] =
                                                    quantity - 1;
                                              } else {
                                                cartItems.remove(product);
                                              }
                                            });
                                           // await _saveBag();
                                          },
                                          icon: const Icon(
                                              Icons.remove_circle_outline),
                                          color: Colors.red,
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              cartItems[product] = quantity + 1;
                                            });
                                           // await _saveBag();
                                          },
                                          icon: const Icon(
                                              Icons.add_circle_outline),
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Total: \$${totalPrice.toStringAsFixed(2)}",
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
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${getTotalItems()} items',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total Price: \$${getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  double getTotalPrice() {
    double total = 0;
    cartItems.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  int getTotalItems() {
    int total = 0;
    cartItems.forEach((_, quantity) {
      total += quantity;
    });
    return total;
  }
}