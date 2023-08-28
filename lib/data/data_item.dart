import 'package:app_pizzeria/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/menu_widget/categories_buttons_tab.dart';


class DataItem {
  DataItem({
    required this.key,
    required this.image,
    required this.name,
    required this.ingredients,
    required this.initialPrice,
    required this.category,
    this.menuDefault = true,
    this.quantity = 1,
  }) {
    addedIngredients.addAll(List.filled(ingredients.length, false));
    isSelected.addAll(List.filled(ingredients.length, true));
  }

  final String image;
  final String name;
  List<String> ingredients;
  final double initialPrice;
  final Categories category;
  List<bool> addedIngredients = [];
  List<bool> isSelected = [];
  final UniqueKey key;
  int quantity;
  bool menuDefault;

  void addIngredients(String ingredient) {
    ingredients.add(ingredient);
    addedIngredients.add(true);
    isSelected.add(true);
  }

  double calculatePrice(BuildContext context) {
    double price = initialPrice;
    for (String ingredient in ingredients) {
      if (addedIngredients[ingredients.indexOf(ingredient)] &&
          isSelected[ingredients.indexOf(ingredient)]) {
        price = price + Provider.of<MenuProvider>(context, listen: false).ingredients[ingredient]!;
      }
    }
    return price * quantity;
  }

  DataItem copy() {
    return DataItem(
      key: UniqueKey(),
      image: image,
      name: name,
      ingredients: List.from(ingredients),
      initialPrice: initialPrice,
      category: category,
      menuDefault: menuDefault,
      quantity: quantity,
    );
  }

  void clearList() {
    final indexes = [];
    for (String ingredient in ingredients) {
      if (!isSelected[ingredients.indexOf(ingredient)]) {
        indexes.add(ingredients.indexOf(ingredient));
      }
    }

    for (int index in indexes) {
      isSelected.removeAt(index);
      addedIngredients.removeAt(index);
      ingredients.removeAt(index);
    }
  }
}
