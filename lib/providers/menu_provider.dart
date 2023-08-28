import 'package:app_pizzeria/data/data_item.dart';
import 'package:app_pizzeria/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  List<DataItem> menu = [];
  Map<String, double> ingredients = {};

  void retrieveMenu() async {
    menu = await getMenu();
  }

  void retrieveIngredients() async {
    ingredients = await getSavedIngredients();
  }

  void updateMenu() {
    final menu = FirebaseFirestore.instance.collection('menu').doc("elements");

    final ingredients =
        FirebaseFirestore.instance.collection('menu').doc("ingredients");

    menu.snapshots().listen((querySnapshot) {
      retrieveMenu();
      notifyListeners();
    });

    ingredients.snapshots().listen((querySnapshot) {
      retrieveIngredients();
      notifyListeners();
    });
  }
}
