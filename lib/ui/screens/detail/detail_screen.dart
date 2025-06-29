import 'package:family_shop/data/local/shared_prefs_service.dart';
import 'package:family_shop/model/favorite_model.dart';
import 'package:family_shop/model/product.dart';
import 'package:family_shop/ui/screens/shoppingCart/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            icon: Icon(size: 30, Icons.arrow_back),
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
            icon: Icon(size: 30, Icons.shopping_bag_outlined),
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
              Image.network(
                widget.product.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    // child: IconButton(
                    //   onPressed: () async {
                    //     setState(() {
                    //       isLiked = !isLiked;
                      //     if (isLiked) {
                      //       bool isExist = favoriteList.any(
                      //         (element) => element.id == widget.product.id,
                      //       );
                      //       if (!isExist) {
                      //         favoriteList.add(widget.product);
                      //       }
                      //     } else {
                      //       favoriteList.removeWhere(
                      //         (element) => element.id == widget.product.id,
                      //       );
                      //     }
                      //   });
                      //   await shared.setBoolData(
                      //       'isLiked_${widget.product.id}', isLiked);
                      //   await shared.saveProductList(
                      //       'favoriteList', favoriteList);
                      // },
                    //   icon: isLiked
                    //       ? Icon(
                    //           size: 30,
                    //           Icons.favorite,
                    //           color: Colors.red,
                    //         )
                    //       : Icon(
                    //           size: 30,
                    //           Icons.favorite_border,
                    //           color: Colors.grey,
                    //         ),
                    // ),
                  ),
                ],
              ),
              Text(
                widget.product.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                    //bag.add(widget.product);
                   // await SharedPrefsService().saveProductList('bagList', bag);
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
    final prefsService = SharedPrefsService();
    isLiked =
        await prefsService.getBoolData('isLiked_${widget.product.id}') ?? false;
    if (isLiked) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final favoriteModel =
            Provider.of<FavoriteModel>(context, listen: false);
        if (!favoriteModel.favorites.contains(widget.product)) {
          favoriteModel.add(widget.product);
        }
      });
    }
    setState(() {});
  }
}
