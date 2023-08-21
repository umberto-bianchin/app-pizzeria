import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/home_widget/suggested_tabs.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/home_widget/categories_cards_tab.dart';
import 'package:app_pizzeria/widget/home_widget/introduction_banner.dart';
import 'package:app_pizzeria/widget/home_widget/position_map.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.onSelectCategory});

  final void Function(int index, {Categories? selectedCategory})
      onSelectCategory;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IntroductionPizzeria(),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              "Categorie",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          CategoriesTabs(onTap: onSelectCategory),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              "Suggeriti",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SuggestedTabs(),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 40,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dove Siamo?",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Via Pizzeria 35, Padova",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Maps(),
        ],
      ),
    );
  }
}
