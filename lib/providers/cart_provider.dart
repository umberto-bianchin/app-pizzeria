import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/data_item.dart';
import 'package:collection/collection.dart';

class CartItemsProvider with ChangeNotifier {
  List<DataItem> cartList = [];
  List<DataItem> orderList = [];

  bool ordered = false;
  bool modified = false;
  bool confirmed = false;
  double orderPrice = 0;
  String time = "";
  String deliveryMethod = "";

  List<DataItem> get cart => cartList;
  int get element {
    int elementCount = 0;
    for (DataItem item in cartList) {
      elementCount += item.quantity;
    }

    return elementCount;
  }

  void addItem(DataItem item) {
    item.clearList();
    item.menuDefault = false;

    for (DataItem itemList in cartList) {
      if (itemList.name == item.name &&
          const DeepCollectionEquality.unordered()
              .equals(itemList.ingredients, item.ingredients)) {
        itemList.quantity += item.quantity;
        notifyListeners();
        return;
      }
    }

    cartList.add(item);

    if (ordered) {
      modified = true;
    }

    notifyListeners();
  }

  void removeItem(DataItem item) {
    cartList.remove(item);

    if (cartList.isEmpty) {
      modified = false;
      ordered = false;
    }

    if (ordered) {
      modified = true;
    }

    notifyListeners();
  }

  void changeQuantity(DataItem item, int quantity) {
    item.quantity = quantity;

    if (cartList.isEmpty) {
      modified = false;
      ordered = false;
    }

    if (ordered) {
      modified = true;
    }

    notifyListeners();
  }

  void changeIngredient(DataItem item, int index, bool value) {
    item.isSelected[index] = value;

    if (ordered) {
      modified = true;
    }

    notifyListeners();
  }

  double getTotal() {
    double amount = 0.0;

    for (DataItem item in cartList) {
      amount += item.calculatePrice();
    }
    return amount;
  }

  double difference() {
    return getTotal() - orderPrice;
  }

  void submitOrder() {
    orderPrice = getTotal();
    ordered = true;
    modified = false;

    for (DataItem item in cartList) {
      orderList.add(item.copy());
    }

    updateState();
    notifyListeners();
  }

  void updateState() {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    DocumentReference reference = FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .collection("orders")
        .doc("order");

    reference.snapshots().listen((querySnapshot) {
      confirmed = querySnapshot.get("accepted") == "True" ? true : false;
      if (confirmed) {
        time = querySnapshot.get("time-interval");
        cartList = orderList;
      }

      notifyListeners();
    });
  }
}
