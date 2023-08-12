import 'package:app_pizzeria/data/data_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<List<DataItem>> {
  CartNotifier(super._state);

  List<DataItem> cart = [];

  void addToCart(DataItem item) {
    cart.add(item);
  }

  void removeToCart(DataItem item) {
    cart.remove(item);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<DataItem>>(
  (ref) => CartNotifier([]),
);

final cartItemProvider = Provider((ref) {
  final cartItem = ref.watch(cartProvider);
  return cartItem;
});
