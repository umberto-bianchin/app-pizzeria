import 'package:app_pizzeria/widget/element_card.dart';
import 'package:app_pizzeria/widget/categories_buttons_tab.dart';

import 'package:flutter/material.dart';

class CategoriesTabs extends StatelessWidget {
  const CategoriesTabs({
    super.key,
    required this.onTap,
  });

  final void Function(int index, {Categories selectedCategory}) onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 160.0,
      width: width,
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        scrollDirection: Axis.horizontal,
        children: [
          FoodCard(width, capitalize(Categories.pizza.name),
              "assets/images/pizza.png", onTap,
              category: Categories.pizza),
          FoodCard(width, capitalize(Categories.panari.name),
              "assets/images/mexican.png", onTap,
              category: Categories.panari),
          FoodCard(width, capitalize(Categories.panini.name),
              "assets/images/burger.png", onTap,
              category: Categories.panini),
          FoodCard(width, capitalize(Categories.bibite.name),
              "assets/images/drink.png", onTap,
              category: Categories.bibite)
        ],
      ),
    );
  }
}
