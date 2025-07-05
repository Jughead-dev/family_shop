import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_shop/config/app_colors.dart';
import 'package:family_shop/data/local/shared_prefs_service.dart';
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
  SharedPrefsService shared = SharedPrefsService();
  @override
  void initState() {
    super.initState();
    loadLikedState();
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
                        await shared.setBoolData(
                            'isLiked_${widget.product.id}', isLiked);

                        List<Product> favoriteList =
                            await shared.getProductList('favoriteList');
                        if (isLiked) {
                          bool isExist = favoriteList.any(
                            (element) => element.id == widget.product.id,
                          );
                          if (!isExist) {
                            favoriteList.add(widget.product);
                          }
                        } else {
                          favoriteList.removeWhere(
                            (element) => element.id == widget.product.id,
                          );
                        }
                          await shared.saveProductList('favoriteList', favoriteList);
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
                    //   bag.add(widget.product);
                    //  await SharedPrefsService().saveProductList('bagList', bag);
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

  Future<void> loadLikedState() async {
    final shared = SharedPrefsService();
    isLiked = await shared.getBoolData('isLiked_${widget.product.id}') ?? false;
    setState(() {});
  }
}
