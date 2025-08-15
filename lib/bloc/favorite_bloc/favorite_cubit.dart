
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/favorite_bloc/favorite_state.dart';
import 'package:oila_market/data/repository/product_repository.dart';
import 'package:oila_market/model/product.dart';

class FavoriteCubit extends Cubit<FavoriteState> {


  
  FavoriteCubit() : super(const FavoriteState());

  Future<void> getFavoriteItems() async {
  //   final favoriteEntities = await repository.allFavorites.first;
    
  //  final favorites = favoriteEntities.map((e) => e.toProduct()).toList();
    
  //   emit(state.copyWith(favorites: favorites));
  }

 
  Future<void> toggleFavorite(Product product) async {
   
    // await repository.toggleFavorite(product);
  }
}
