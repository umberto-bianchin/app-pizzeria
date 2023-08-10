import 'package:flutter/material.dart';
import 'package:app_pizzeria/data/menu_items_list.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: items
          .where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()) ||
              element.ingredients.toLowerCase().contains(name.toLowerCase()))
          .toList(),
    );
  }
}
