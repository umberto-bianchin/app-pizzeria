import 'package:app_pizzeria/widget/food_card.dart';
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
        scrollDirection: Axis.horizontal,
        children: [
          FoodCard(width, "Pizze", "assets/images/pizza.png"),
          FoodCard(width, "Kebab", "assets/images/mexican.png"),
          FoodCard(width, "Panini", "assets/images/burger.png"),
          FoodCard(width, "Drink", "assets/images/drink.png")
        ],
      ),
    );
  }
}
