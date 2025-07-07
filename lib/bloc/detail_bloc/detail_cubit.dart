import 'package:family_shop/bloc/detail_bloc/detail_state.dart';
import 'package:family_shop/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailState());
  void addList(Product product) {
    List<Product> pro = [];
    if (state.bag.contains(product)) {
      product.count++;
    } else {
      pro.add(product);
    }

    emit(state.copyWith(bag: pro));
  }

  void addToBag(Product product) {
    final List<Product> newList = List.from(state.bag);

    final index = newList.indexWhere((e) => e.id == product.id);

    if (index != -1) {
      newList[index].count++;
    } else {
      product.count = 1;
      newList.add(product);
    }

    emit(state.copyWith(bag: newList));
  }
}
