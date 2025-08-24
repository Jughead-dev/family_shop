import 'package:equatable/equatable.dart';
import 'package:oila_market/model/product.dart';

class FavoriteState extends Equatable {
  final List<Product> favorites;

  const FavoriteState({this.favorites = const []});

  FavoriteState copyWith({List<Product>? favorites}) {
    return FavoriteState(favorites: favorites ?? this.favorites);
  }

  factory FavoriteState.initial() => const FavoriteState(favorites: []);

  @override
  List<Object?> get props => [favorites];
}
