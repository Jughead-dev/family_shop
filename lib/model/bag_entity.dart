import 'package:floor/floor.dart';
import 'package:oila_market/model/product.dart';

@entity
class BagEntity {
  @primaryKey
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final int count;

  BagEntity({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.count = 1,
  });

  Product toProduct() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      count: count,
    );
  }

  BagEntity copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    int? count,
  }) {
    return BagEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      count: count ?? this.count,
    );
  }
}
