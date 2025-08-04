import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/bag_bloc/bag_state.dart';
import 'package:oila_market/model/product.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagState());

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

  void addToBag(Product product) {
    final List<Product> updatedList = List<Product>.from(state.bagList);
    final index = updatedList.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      final updatedProduct = updatedList[index].copyWith(
        count: updatedList[index].count + 1,
      );
      updatedList[index] = updatedProduct;
      print('Yangilandi: $updatedProduct');
    } else {
      final newProduct = product.copyWith(count: 1);
      updatedList.add(newProduct);
      print('Yangi qo‘shildi: $newProduct');
    }

    emit(state.copyWith(bagList: updatedList));
  }
  // void addToBag(Product product) {
  //   List<Product> list = List.from(state.bagList);
  //   bool found = false;

  //   for (int i = 0; i < list.length; i++) {
  //     if (list[i].id == product.id) {
  //       list[i] = list[i].copyWith(count: list[i].count + 1);
  //       print("Yangilandi: ${list[i]}");
  //       found = true;
  //       break;
  //     }
  //   }

  //   if (!found) {
  //     list.add(product.copyWith(count: 1));
  //     print("Yangi qo‘shildi: ${product.copyWith(count: 1)}");
  //   }

  //   emit(state.copyWith(bagList: list));
  // }

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
