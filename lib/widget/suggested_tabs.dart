import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/element_card.dart';

class SuggestedTabs extends StatelessWidget {
  const SuggestedTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void action(int index, {Categories? selectedCategory}) {}

    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 160.0,
      width: width,
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        scrollDirection: Axis.horizontal,
        children: [
          FoodCard(width, "Margherita", "assets/images/classic.png", action),
          FoodCard(width, "Diavola", "assets/images/americana.png", action),
          FoodCard(
              width, "Vegetariana", "assets/images/mexicanPizza.png", action),
        ],
      ),
    );
  }
}
