import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';

import 'package:flutter/material.dart';

import 'category_card.dart';

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
      height: 100.0,
      width: width,
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        scrollDirection: Axis.horizontal,
        children: [
          CategoryCard(width, capitalize(Categories.pizza.name),
              "assets/images/pizza.png", onTap,
              category: Categories.pizza),
          CategoryCard(width, capitalize(Categories.kebab.name),
              "assets/images/mexican.png", onTap,
              category: Categories.kebab),
          CategoryCard(width, capitalize(Categories.panini.name),
              "assets/images/burger.png", onTap,
              category: Categories.panini),
          CategoryCard(width, capitalize(Categories.bibite.name),
              "assets/images/drink.png", onTap,
              category: Categories.bibite)
        ],
      ),
    );
  }
}
