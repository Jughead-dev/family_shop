import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/bag_bloc/bag_state.dart';
import 'package:oila_market/data/local/dao/bag_dao.dart';
import 'package:oila_market/data/local/database/database_service.dart';
import 'package:oila_market/model/bag_entity.dart';
import 'package:oila_market/model/product.dart';

class BagCubit extends Cubit<BagState> {
  BagDao? bagDao;
  BagCubit():super(BagState.initial()) {
    bagDao = DatabaseService.database!.bagDao;
  }
  Future<void> loadBagItems() async {
    final items = await bagDao?.getAllBagItems()??[];

    final entities = items.map((entity)=>entity.toProduct()).toList();
    emit(state.copyWith(bagList: entities, isEmpty: items.isEmpty));
    if ( items.isEmpty) {
      emit(state.copyWith(isEmpty: true));
    } else {
      emit(state.copyWith(isEmpty: false));
    }
  }

  double getTotalPrice() {
    double total = 0;
    for (int i = 0; i < state.bagList.length; i++) {
      total += state.bagList[i].price * state.bagList[i].count;
    }
    return total;
  }

  int getTotalItems() {
    return state.bagList.length;
  }

  void clearBag() async {
    await bagDao?.deleteBagItem(state.bagList as BagEntity);
    emit(state.copyWith(bagList: [], isEmpty: true));
  }

  void addToBag(Product product) {
    final List<Product> updatedList = List<Product>.from(state.bagList);
    final index = updatedList.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      final updatedProduct = updatedList[index].copyWith(
        count: updatedList[index].count + 1,
      );
      updatedList[index] = updatedProduct;
    } else {
      final newProduct = product.copyWith(count: 1);
      updatedList.add(newProduct);
    }

    emit(state.copyWith(bagList: updatedList));
  }

  void removeFromBag(Product product) {
    List<Product> list = List.from(state.bagList);
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == product.id) {
        if (list[i].count > 1) {
          list[i] = list[i].copyWith(count: list[i].count - 1);
        } else {
          list.removeAt(i);
        }
        break;
      }
    }
    emit(state.copyWith(bagList: list));
  }
}
