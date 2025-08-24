import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/bag_bloc/bag_state.dart';
import 'package:oila_market/data/local/dao/bag_dao.dart';
import 'package:oila_market/model/product.dart';

class BagCubit extends Cubit<BagState> {
  final BagDao bagDao;
  BagCubit(this.bagDao) : super(BagState.initial());

  Future<void> loadBagItems() async {
    final items = await bagDao.getAllBagItems();
    final products = items.map((e) => e.toProduct()).toList();
    emit(state.copyWith(bagList: products, isEmpty: products.isEmpty));
  }

  double getTotalPrice() => state.bagList.fold(
        0.0,
        (sum, p) => sum + (p.price * p.count),
      );

  int getTotalItems() => state.bagList.length;

  Future<void> clearBag() async {
    await bagDao.clearBag();
    emit(state.copyWith(bagList: [], isEmpty: true));
  }

  Future<void> addToBag(Product product, {required Function() onAdded}) async {
    final pid = product.id;
    if (pid == null) return;

    final existing = await bagDao.getBagItemById(pid);
    if (existing != null) {
      await bagDao.updateBagItem(existing.copyWith(count: existing.count + 1));
    } else {
      await bagDao.insertBagItem(product.toBagEntity);
    }

    final list = await bagDao.getAllBagItems();
    final updated = list.map((e) => e.toProduct()).toList();
    emit(state.copyWith(bagList: updated, isEmpty: updated.isEmpty));
    onAdded();
  }

  Future<void> removeFromBag(Product product) async {
    final pid = product.id;
    if (pid == null) return;

    final existing = await bagDao.getBagItemById(pid);
    if (existing == null) return;

    if (existing.count > 1) {
      await bagDao.updateBagItem(existing.copyWith(count: existing.count - 1));
    } else {
      await bagDao.deleteBagItem(existing);
    }

    final list = await bagDao.getAllBagItems();
    final updated = list.map((e) => e.toProduct()).toList();
    emit(state.copyWith(bagList: updated, isEmpty: updated.isEmpty));
  }
}
