import 'package:app_pizzeria/data/data_item.dart';
import 'package:app_pizzeria/helper.dart';
import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuProvider with ChangeNotifier {
  List<DataItem> menu = [];
  Map<String, double> ingredients = {};

  Future<void> retrieveMenu() async {
    menu = await getMenu();
    
  }

  Future<void> retrieveIngredients() async {
    ingredients = await getSavedIngredients();
  }

  void updateMenu(BuildContext context) {
    final menu = FirebaseFirestore.instance.collection('menu').doc("elements");

    final ingredients =
        FirebaseFirestore.instance.collection('menu').doc("ingredients");

    menu.snapshots().listen((querySnapshot) async {
      await retrieveMenu();
      if (context.mounted) {
        validateCartMenu(context);
      }
      notifyListeners();
    });

    ingredients.snapshots().listen((querySnapshot) async {
      await retrieveIngredients();

      if (context.mounted) {
        validateCartIngredients(context);
      }
      notifyListeners();
    });
  }

  validateCartIngredients(BuildContext context) {
    List<DataItem> items = [];

    items.addAll(
        Provider.of<CartItemsProvider>(context, listen: false).cartList);

    for (DataItem item in items) {
      if (!item.ingredients
          .every((ingr) => ingredients.containsKey(ingr.toLowerCase()))) {
        Provider.of<CartItemsProvider>(context, listen: false).removeItem(item);
      }
    }
  }

  validateCartMenu(BuildContext context) {
    List<DataItem> items = [];

    items.addAll(
        Provider.of<CartItemsProvider>(context, listen: false).cartList);

    for (DataItem item in items) {
      if (!menu.any((element) => item.name == element.name)) {
        Provider.of<CartItemsProvider>(context, listen: false).removeItem(item);
      }
    }
  }
}
