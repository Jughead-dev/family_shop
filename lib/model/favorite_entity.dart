import 'package:floor/floor.dart';
import 'package:oila_market/model/product.dart';

@Entity(tableName: "favorites")
class FavoriteEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final int count;

  FavoriteEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.count = 1,
  });

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteEntity(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      count: json['count'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'count': count,
      };

  @override
  bool operator ==(Object other) {
    return other is FavoriteEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

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
}
