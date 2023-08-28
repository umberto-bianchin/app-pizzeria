import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/home_widget/suggested_card.dart';

import '../../data/data_item.dart';

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
          SuggestedCard(
            DataItem(
              key: UniqueKey(),
              image: "assets/images/classic.png",
              name: "Margherita",
              ingredients: [
                
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
