import 'package:family_shop/model/global_list.dart';
import 'package:family_shop/model/product.dart';
import 'package:family_shop/pages/shopping_cart.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLiked = false;
  int son = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(6),
          child: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: Icon(size: 30, Icons.arrow_back)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCart(),
                ),
              );
            },
            icon: Icon(size: 30, Icons.shopping_bag_outlined),
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
                                  size: 30,
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  size: 30,
                                  Icons.favorite_border,
                                  color: Colors.grey,
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
                child: InkWell(
                  onTap: () {
                    setState(() {
                      bag.add(widget.product);
                    });
                  },
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
