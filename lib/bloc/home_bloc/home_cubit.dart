import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/home_bloc/home_state.dart';
import 'package:oila_market/data/remote/shop_api.dart';
import 'package:oila_market/model/product.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()); 

  Future<void> getProduct() async {
    emit(state.copyWith(isLoading: true));
    try {
      var res = await ShopApi.GET(ShopApi.PRODUCTS_LIST, {});
      if (res != null) {
        final newProduct = productsFromJson(res);
        emit(state.copyWith(products: newProduct, isLoading: false));
      } else {
        
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void fetchData() async {
   await Future.wait([
      getProduct(),
    ]);
  }

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true));

    final respone = await ShopApi.GET(ShopApi.PRODUCTS_LIST, {});

    if (respone != null) {
      final newProduct = productsFromJson(respone);
       emit(state.copyWith(products: newProduct, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}