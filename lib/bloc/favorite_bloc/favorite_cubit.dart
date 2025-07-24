import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/favorite_bloc/favorite_state.dart';
import 'package:oila_market/model/product.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());
  void addToFavorites(Product product) {
    final updatedFavorites = List<Product>.from(state.favorites);
    if (!updatedFavorites.any((item) => item.id == product.id)) {
      updatedFavorites.add(product);
    }
    emit(state.copyWith(favorites: updatedFavorites));
  }

  void removeFavorites(Product product) {
    final updatedFavorites = List<Product>.from(state.favorites)
      ..removeWhere((item) => item.id == product.id);
    emit(state.copyWith(favorites: updatedFavorites));
  }

  bool isFavorite(Product product) {
    return state.favorites.any((item) => item.id == product.id);
  }
}
