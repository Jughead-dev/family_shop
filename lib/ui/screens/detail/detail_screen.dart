import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_shop/config/app_colors.dart';
import 'package:family_shop/model/product.dart';
import 'package:family_shop/ui/screens/shoppingCart/shopping_cart.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLiked = false;
  int son = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(6),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
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
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            ),
          ),
          SizedBox(width: 18),
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
              CachedNetworkImage(
                imageUrl: widget.product.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "\$${widget.product.price.toString()}",
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
                    child: IconButton(
                      onPressed: () async {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      icon: isLiked
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                              size: 30,
                            ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.product.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 22),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 112),
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
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.info),
                              Text("Mahsulot qoshildi"),
                            ],
                          ),
                          showCloseIcon: true,
                        ),
                      );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ShoppingCart()),
                    );
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
