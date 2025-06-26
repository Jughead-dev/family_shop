import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_shop/model/global_list.dart';
import 'package:family_shop/model/product.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  Map<Product, int> cartItems = {};
  bool isEmpty = false;
  bool remove = false;
  @override
  void initState() {
    super.initState();
    isEmptys();
    for (var i in bag) {
      cartItems[i] = (cartItems[i] ?? 0) + 1;
    }
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
        title: Text("Your Bag"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                bag.clear();
              },
              icon: Icon(size: 30, Icons.delete_rounded),
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems.keys.elementAt(index);
                final quantity = cartItems[product] ?? 1;
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
                          padding: EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            imageUrl: product.image,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product.category,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "\$${product.price.toStringAsFixed(2)} each",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          cartItems[product] = quantity - 1;
                                        } else {
                                          cartItems.remove(product);
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle_outline),
                                    color: Colors.red,
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        cartItems[product] = quantity + 1;
                                      });
                                    },
                                    icon: Icon(Icons.add_circle_outline),
                                    color: Colors.green,
                                  ),
                                  Spacer(),
                                  Text(
                                    "Total: \$${totalPrice.toString()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
    );
  }

  void isEmptys() {
    if (bag.isEmpty) {
      setState(() {
        isEmpty = false;
      });
    } else {
      setState(() {
        isEmpty = false;
      });
    }
  }
}
