import 'package:app_pizzeria/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/home_widget/suggested_card.dart';
import 'package:provider/provider.dart';

class SuggestedTabs extends StatelessWidget {
  const SuggestedTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final suggested = Provider.of<MenuProvider>(context)
        .menu
        .where((element) => element.important)
        .toList();

    if (suggested.isNotEmpty) {
      return SizedBox(
        height: 140.0,
        width: width,
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 15, right: 15),
          scrollDirection: Axis.horizontal,
          itemCount: suggested.length,
          itemBuilder: (context, index) {
            return SuggestedCard(suggested[index]);
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          "Non ci sono pizze suggerite oggi!",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
  }
}
