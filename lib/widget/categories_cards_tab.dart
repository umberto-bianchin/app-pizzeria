import 'package:app_pizzeria/widget/element_card.dart';
import 'package:app_pizzeria/widget/categories_buttons_tab.dart';

import 'package:flutter/material.dart';

class CategoriesTabs extends StatelessWidget {
  const CategoriesTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 140.0,
      width: width,
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        scrollDirection: Axis.horizontal,
        children: [
          FoodCard(width, capitalize(Categories.pizza.name),
              "assets/images/pizza.png"),
          FoodCard(width, capitalize(Categories.kebab.name),
              "assets/images/mexican.png"),
          FoodCard(width, capitalize(Categories.panini.name),
              "assets/images/burger.png"),
          FoodCard(width, capitalize(Categories.bibite.name),
              "assets/images/drink.png")
        ],
      ),
    );
  }
}
