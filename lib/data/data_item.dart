import 'package:flutter/material.dart';

import '../widget/categories_buttons_tab.dart';
import 'menu_items_list.dart';

Color kprimaryColor = const Color.fromARGB(255, 4, 167, 113);

class DataItem {
  DataItem({
    required this.key,
    required this.image,
    required this.name,
    required this.ingredients,
    required this.initialPrice,
    required this.category,
    this.quantity = 1,
  }) {
    addedIngredients.addAll(List.filled(ingredients.length, false));
    isSelected.addAll(List.filled(ingredients.length, true));
  }

  final String image;
  final String name;
  List<Ingredients> ingredients;
  final double initialPrice;
  final Categories category;
  List<bool> addedIngredients = [];
  List<bool> isSelected = [];
  final UniqueKey key;
  int quantity;

  void addIngredients(Ingredients ingredient) {
    ingredients.add(ingredient);
    addedIngredients.add(true);
    isSelected.add(true);
  }

  double calculatePrice() {
    double price = initialPrice;
    for (Ingredients ingredient in ingredients) {
      if (addedIngredients[ingredients.indexOf(ingredient)] &&
          isSelected[ingredients.indexOf(ingredient)]) {
        price = price + costIngredients[ingredient]!;
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
        category: category);
  }
}
