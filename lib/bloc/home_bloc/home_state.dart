
import 'package:equatable/equatable.dart';
import 'package:oila_market/model/product.dart';

class HomeState extends Equatable {
  final List<Product> products;
  final bool isLoading;

  const HomeState({
    this.products = const [],
    this.isLoading = false,
  });

  HomeState copyWith({
    List<Product>? products,
    bool? isLoading,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [isLoading, products];
}