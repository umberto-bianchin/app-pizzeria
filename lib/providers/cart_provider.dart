import 'package:flutter/material.dart';
import '../data/data_item.dart';
import 'package:collection/collection.dart';

class CartItemsProvider with ChangeNotifier {
  List<DataItem> cartList = [];

  List<DataItem> get cart => cartList;

  void addItem(DataItem item) {
    item.clearList();
    item.menuDefault = false;

    for (DataItem itemList in cartList) {
      if (itemList.name == item.name &&
          const DeepCollectionEquality.unordered()
              .equals(itemList.ingredients, item.ingredients)) {
        itemList.quantity += 1;
        notifyListeners();
        return;
      }
    }

    cartList.add(item);
    notifyListeners();
  }

  void removeItem(DataItem item) {
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      cartList.remove(item);
    }

    notifyListeners();
  }

  void changeQuantity(DataItem item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }

  double getTotal() {
    double amount = 0.0;

    for (DataItem item in cartList) {
      amount += item.calculatePrice();
    }

    return amount;
  }
}
