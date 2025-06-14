import 'package:family_shop/model/product.dart';
import 'package:family_shop/model/user.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final User user;
  final Product product;
  const UserItem({super.key, required this.user, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(product.image),
        ],
      ),
    );
  }
}
