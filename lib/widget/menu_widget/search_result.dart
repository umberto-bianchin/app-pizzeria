import 'package:app_pizzeria/providers/menu_provider.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/data_item.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.name, required this.category});

  final String name;
  final Categories category;

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: Provider.of<MenuProvider>(context)
            .menu
            .where((element) =>
                (element.name.toLowerCase().contains(name.toLowerCase()) ||
                    isContained(element)) &&
                element.category == category)
            .map(
              (e) => MenuItem(
                dataItem: e,
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
            .toList());
  }

  bool isContained(DataItem item) {
    for (String ingredient in item.ingredients) {
      if (ingredient.toLowerCase().contains(name.toLowerCase())) {
        return true;
      }
    }
    return false;
  }
}
