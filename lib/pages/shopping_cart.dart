import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_shop/model/global_list.dart';
import 'package:family_shop/pages/detail_page.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  bool isEmpty = false;
  bool remove = false;
  @override
  void initState() {
    super.initState();
    isEmptys();
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
        title: Text("Shopping Cart"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {},
              icon: Icon(size: 30, Icons.delete_rounded),
            ),
          ),
        ],
      ),
      body: isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: bag.length,
              itemBuilder: (context, index) {
                final product = bag[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(product: product),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
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
                            child: Stack(
                              children: [
                                Column(
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
                                      "${product.price}\$",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        bag.remove(product);
                                      });
                                      setState(() {
                                        isEmptys();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline_rounded,
                                    ),
                                    color: Colors.red,
                                    iconSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
