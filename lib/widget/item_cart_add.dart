import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:app_pizzeria/widget/quantity_selector.dart';
import 'package:flutter/material.dart';

class ItemCart extends StatefulWidget {
  const ItemCart({super.key, required this.menuItem});

  final MenuItem menuItem;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(widget.menuItem.image),
              height: 100.0,
              width: 100.0,
            ),
            NumericStepButton(onChanged: (int x) {})
          ],
        )
      ],
    );
  }
}
