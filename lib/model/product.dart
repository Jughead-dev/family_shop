import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:oila_market/model/bag_entity.dart';
import 'package:oila_market/model/favorite_entity.dart';

List<Product> productsFromJson(String str) => List<Product>.from(
      json.decode(str).map((x) => Product.fromJson(x)),
    );

class Product extends Equatable {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final int count;
  final bool isLiked;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.count = 1,
    this.isLiked = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch,
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      count: json['count'] ?? 1,
      isLiked: json['isLiked'] ?? false,
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
        'isLiked': isLiked,
      };

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    int? count,
    bool? isLiked,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      count: count ?? this.count,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  FavoriteEntity get toFavoriteEntity {
    return FavoriteEntity(
      productId: id ?? 0,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      count: count,
    );
  }

  BagEntity get toBagEntity {
    return BagEntity(
      id: id ?? 0,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      count: count,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, price, description, category, image, count, isLiked];
}
