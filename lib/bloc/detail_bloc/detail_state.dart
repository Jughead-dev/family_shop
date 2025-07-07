import 'package:equatable/equatable.dart';
import 'package:family_shop/model/product.dart';

class DetailState extends Equatable {
  final List<Product> productlar;
  final List<Product> bag;

  const DetailState({
    this.productlar = const [],
    this.bag = const [],
  });

  DetailState copyWith({
    List<Product>? productlar,
    List<Product>? bag,
  }) {
    return DetailState(
      productlar: productlar ?? this.productlar,
      bag: bag ?? this.bag,
    );
  }

  @override
  List<Object?> get props => [productlar,  bag];
}
