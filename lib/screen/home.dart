import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/suggested_tabs.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/categories_cards_tab.dart';
import 'package:app_pizzeria/widget/introduction_banner.dart';
import 'package:app_pizzeria/widget/position_map.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.onSelectCategory});

  final void Function(int index, {Categories? selectedCategory}) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: ListView(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          const IntroductionPizzeria(),
          const SizedBox(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text("Categorie",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          CategoriesTabs(onTap: onSelectCategory),
          const SizedBox(
            height: 15.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text("Suggeriti",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          const SuggestedTabs(),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 40,
            ),
            child: Text("Dove Siamo?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          const Maps(),
        ],
      ),
    );
  }
}
