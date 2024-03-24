import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';

import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoriesTabs extends StatelessWidget {
  const CategoriesTabs({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 100.0,
      width: width,
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        scrollDirection: Axis.horizontal,
        children: [
          CategoryCard(width, capitalize(Categories.pizze.name),
              "assets/images/pizza.png",
              category: Categories.pizze),
          CategoryCard(width, capitalize(Categories.panari.name),
              "assets/images/mexican.png",
              category: Categories.panari),
          CategoryCard(width, capitalize(Categories.panini.name),
              "assets/images/burger.png",
              category: Categories.panini),
          CategoryCard(width, capitalize(Categories.bibite.name),
              "assets/images/drink.png",
              category: Categories.bibite)
        ],
      ),
    );
  }
}
