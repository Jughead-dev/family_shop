import 'package:equatable/equatable.dart';
import 'package:oila_market/model/product.dart';

class BagState extends Equatable {
  final bool isEmpty;
  final bool isLoading;
  final List<Product> allProduct;
  final List<Product> bagList;

  const BagState({
    this.isLoading = false,
    this.isEmpty = false,
    this.bagList = const [],
    this.allProduct = const [],
  });

  BagState copyWith({
    bool? isLoading,
    bool? isEmpty,
    List<Product>? bagList,
    List<Product>? allProduct,
  }) {
    return BagState(
      isEmpty: isEmpty ?? this.isEmpty,
      isLoading: isLoading ?? this.isLoading,
      bagList: bagList ?? this.bagList,
      allProduct: allProduct ?? this.allProduct,
    );
  
  }
  static BagState initial() {
    return const BagState(
      isEmpty: true,
      isLoading: false,
      bagList: [],
      allProduct: [],
    );
  }

  @override
  List<Object?> get props => [isEmpty, isLoading, bagList, allProduct];
}