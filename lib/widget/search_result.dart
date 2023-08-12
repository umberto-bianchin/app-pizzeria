import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/data/menu_items_list.dart';

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
                  element.dataItem.ingredients.contains(name.toLowerCase())) &&
              element.dataItem.category == category))
          .toList(),
    );
  }
}
