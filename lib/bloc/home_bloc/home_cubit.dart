import 'package:family_shop/bloc/home_bloc/home_state.dart';
import 'package:family_shop/data/remote/shop_api.dart';
import 'package:family_shop/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> getProduct() async {
    var res = await ShopApi.GET(ShopApi.PRODUCTS_LIST, {});
    if (res != null) {
      final newProduct = userFromJson(res);
      emit(state.copyWith(products: newProduct, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void fetchData() async {
    await Future.wait([
      getProduct(),
    ]);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true));

    final respone = await ShopApi.GET(ShopApi.PRODUCTS_LIST, {});

    if (respone != null) {
      final newProduct = userFromJson(respone);
      state.products.clear();
      emit(state.copyWith(products: newProduct, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
