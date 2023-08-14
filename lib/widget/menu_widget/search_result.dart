import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/data/menu_items_list.dart';
import '../../data/data_item.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.name, required this.category});

  final String name;
  final Categories category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: items
          .where((element) => ((element.dataItem.name
                      .toLowerCase()
                      .contains(name.toLowerCase()) ||
                  isContained(element.dataItem)) &&
              element.dataItem.category == category))
          .toList(),
    );
  }

  bool isContained(DataItem item) {
    for (Ingredients ingredient in item.ingredients) {
      if (ingredient.name.toLowerCase().contains(name.toLowerCase())) {
        return true;
      }
    }
    return false;
  }
}
