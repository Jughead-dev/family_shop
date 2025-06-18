import 'package:family_shop/model/product.dart';
import 'package:family_shop/pages/shopping_cart.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({required this.product, super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isLiked = false;
  int son = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(size: 30, Icons.arrow_back_ios)),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCart(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 12),
              Image.network(widget.product.image,
                  height: 300, width: 330, fit: BoxFit.cover),
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "\$${widget.product.price.toString()}",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          icon: isLiked
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ))),
                ],
              ),
              Text(
                widget.product.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              SizedBox(height: 22),
              Text(
                widget.product.description,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 112),
            ],
          ),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 50, right: 20),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         flex: 2,
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: Colors.green,
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //           height: 60,
      //           child: InkWell(
      //             child: Padding(
      //               padding: const EdgeInsets.only(top: 16),
      //               child: Text(
      //                 "Add Cart",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: Container(
        height: 80,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (son > 1) {
                    son = son - 1;
                  }
                });
              },
              icon: Icon(Icons.remove_circle_outline, size: 28),
            ),
            SizedBox(width: 3),
            Text(son.toString(), style: TextStyle(fontSize: 28)),
            SizedBox(width: 3),
            IconButton(
              onPressed: () {
                setState(() {
                  son = son + 1;
                });
              },
              icon: Icon(Icons.add_circle_outline, size: 28),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
