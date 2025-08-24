import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/favorite_bloc/favorite_state.dart';
import 'package:oila_market/data/local/dao/favorite_dao.dart';
import 'package:oila_market/model/favorite_entity.dart';
import 'package:oila_market/model/product.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteDao dao;

  FavoriteCubit(this.dao) : super(FavoriteState.initial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final entities = await dao.getAll();
    final list = entities.map((e) => e.toProduct()).toList();
    emit(state.copyWith(favorites: list));
  }

  Future<void> toggleFavorite(Product product) async {
    final id = product.id ?? 0;
    final exists = await dao.getByProductId(id);

    if (exists != null) {
      await dao.deleteByProductId(id);
    } else {
      await dao.insertItem(FavoriteEntity.fromProduct(product));
    }
    await loadFavorites();
  }

  Future<void> deleteFavorite(Product product) async {
    await dao.deleteByProductId(product.id ?? 0);
    await loadFavorites();
  }

  Future<void> clearFavorites() async {
    await dao.clear();
    await loadFavorites();
  }

  bool isFavorite(Product product) {
    final id = product.id ?? 0;
    return state.favorites.any((p) => (p.id ?? 0) == id);
  }
}
