import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/element_card.dart';

class SuggestedTabs extends StatelessWidget {
  const SuggestedTabs({
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
          FoodCard(width, "Mexican", "assets/images/mexicanPizza.png"),
          FoodCard(width, "Vegetarian", "assets/images/veg.png"),
          FoodCard(width, "Americana", "assets/images/americana.png"),
          FoodCard(width, "Classic", "assets/images/classic.png")
        ],
      ),
    );
  }
}
