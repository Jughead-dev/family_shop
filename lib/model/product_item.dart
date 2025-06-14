import 'package:family_shop/model/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 100,
      height: 160,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(height: 72),
          Image.network(product.image,
              height: 100, width: 100, fit: BoxFit.cover),
          SizedBox(height: 8),
          Text(
            product.title,
            style: TextStyle(color: Colors.black, fontSize: 18),
 
          ),
          Text(
            "\$${product.price.toString()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
