import 'package:app_pizzeria/data/data_item.dart';
import 'package:app_pizzeria/helper.dart';
import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuProvider with ChangeNotifier {
  List<DataItem> menu = [];
  Map<String, double> ingredients = {};

  void retrieveMenu() async {
    menu = await getMenu();
  }

  void retrieveIngredients() async {
    ingredients = await getSavedIngredients();
  }

  void updateMenu(BuildContext context) {
    final menu = FirebaseFirestore.instance.collection('menu').doc("elements");

    final ingredients =
        FirebaseFirestore.instance.collection('menu').doc("ingredients");

    menu.snapshots().listen((querySnapshot) {
      retrieveMenu();
      checkCart(context);
      notifyListeners();
    });

    ingredients.snapshots().listen((querySnapshot) {
      retrieveIngredients();
      checkCart(context);
      notifyListeners();
    });
  }

  checkCart(BuildContext context) {
    List<DataItem> items = [];

    items.addAll(
        Provider.of<CartItemsProvider>(context, listen: false).cartList);

    for (DataItem item in items) {
      if (!menu.any((element) => element.name == item.name) ||
          !item.ingredients.any(((ingr) => ingredients.containsKey(ingr)))) {
        Provider.of<CartItemsProvider>(context, listen: false)
            .cartList
            .removeWhere((element) => element.name == item.name);
      }
    }
  }
}
