import 'package:floor/floor.dart';
import 'package:oila_market/model/product.dart';

@Entity(tableName: 'favorite_entity')
class FavoriteEntity {
  @PrimaryKey(autoGenerate: true)
  final int? productId;

  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final int count;

  const FavoriteEntity({
    required this.productId,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    this.count = 1,
  });

  factory FavoriteEntity.fromProduct(Product p) {
    return FavoriteEntity(
      productId: (p.id ?? 0),
      title: p.title,
      description: p.description,
      category: p.category,
      image: p.image,
      price: p.price,
      count: p.count,
    );
  }

  Product toProduct() {
    return Product(
      id: productId,
      title: title,
      description: description,
      category: category,
      image: image,
      price: price,
      count: count,
    );
  }
   FavoriteEntity copyWith({
    int? productId,
    String? title,
    String? description,
    String? category,
    String? image,
    double? price,
    int? count,
  }) {
    return FavoriteEntity(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      price: price ?? this.price,
      count: count ?? this.count,
    );
  }
}
