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
    int total = 0;
    for (var product in state.bagList) {
      total += product.count;
    }
    return total;
  }

  void addToBag(Product product) {
    final updatedList = List<Product>.from(state.bagList);
    final index = updatedList.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      updatedList[index] =
          updatedList[index].copyWith(count: updatedList[index].count + 1);
    } else {
      updatedList.add(product);
    }

    emit(state.copyWith(bagList: updatedList));
  }

  void removeFromBag(Product product) {
    final updatedList = List<Product>.from(state.bagList);
    final index = updatedList.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      if (updatedList[index].count > 1) {
        updatedList[index] =
            updatedList[index].copyWith(count: updatedList[index].count - 1);
      } else {
        updatedList.removeAt(index);
      }
    }

    emit(state.copyWith(bagList: updatedList));
  }
}
