import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/element_card.dart';

import '../data/data_item.dart';
import '../data/menu_items_list.dart';

class SuggestedTabs extends StatelessWidget {
  const SuggestedTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void action(int index, {Categories? selectedCategory}) {}

    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 140.0,
      width: width,
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        scrollDirection: Axis.horizontal,
        children: [
          SuggestedCard(
            DataItem(
              key: UniqueKey(),
              image: "assets/images/burger.png",
              name: "A4",
              ingredients: [
                Ingredients.mozzarella,
                Ingredients.salsiccia,
                Ingredients.cipolla,
                Ingredients.gorgonzola,
                Ingredients.funghi
              ],
              initialPrice: 6.5,
              category: Categories.panini,
            ),
          ),
          SuggestedCard(
            DataItem(
              key: UniqueKey(),
              image: "assets/images/burger.png",
              name: "A4",
              ingredients: [
                Ingredients.mozzarella,
                Ingredients.salsiccia,
                Ingredients.cipolla,
                Ingredients.gorgonzola,
                Ingredients.funghi
              ],
              initialPrice: 6.5,
              category: Categories.panini,
            ),
          ),
          SuggestedCard(
            DataItem(
              key: UniqueKey(),
              image: "assets/images/burger.png",
              name: "A4",
              ingredients: [
                Ingredients.mozzarella,
                Ingredients.salsiccia,
                Ingredients.cipolla,
                Ingredients.gorgonzola,
                Ingredients.funghi
              ],
              initialPrice: 6.5,
              category: Categories.panini,
            ),
          ),
        ],
      ),
    );
  }
}
