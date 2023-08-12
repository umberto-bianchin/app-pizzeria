import 'package:app_pizzeria/data/menu_items_list.dart';
import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/quantity_selector.dart';
import 'package:app_pizzeria/widget/search_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_item.dart';

class ItemCart extends ConsumerStatefulWidget {
  const ItemCart({super.key, required this.dataItem});

  final DataItem dataItem;

  @override
  ConsumerState<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends ConsumerState<ItemCart> {
  String? dropdownValue;
  final ScrollController _controller = ScrollController();
  String searchedValue = "";
  DataItem? customItem;
  int quantity = 1;

  void setSearchedValue(String search) {
    setState(() {
      searchedValue = search;
    });
  }

  void setQuantity(int x) {
    setState(() {
      quantity = x;
      customItem!.quantity = x;
    });
  }

  void addIngredients(Ingredients ingredient) {
    setState(() {
      customItem!.addIngredients(ingredient);
    });
  }

  void setChecked(int i, bool value) {
    setState(() {
      customItem!.isSelected[i] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    customItem = widget.dataItem.copy();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage(customItem!.image),
              height: 80.0,
            ),
            NumericStepButton(onChanged: setQuantity),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          "Ingredienti:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 2.5,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Scrollbar(
              thumbVisibility: true,
              controller: _controller,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ListView(
                  controller: _controller,
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < customItem!.ingredients.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(capitalize(
                              toStringIngredients(customItem!.ingredients[i]))),
                          SizedBox(
                            height: 40,
                            child: Checkbox(
                              activeColor: Colors.blue,
                              value: customItem!.isSelected[i],
                              shape: const CircleBorder(),
                              onChanged: (bool? value) {
                                setState(() {
                                  setChecked(i, value!);
                                });
                              },
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Prezzo\t\t\t",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              "€${(customItem!.calculatePrice()).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 15, color: Colors.red),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          child: SearchIngredient(onChange: setSearchedValue),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40.0,
          width: MediaQuery.of(context).size.width / 1.2,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 10),
            children: [
              for (Ingredients ingredient in Ingredients.values)
                if (!customItem!.ingredients.contains(ingredient) &&
                    toStringIngredients(ingredient).contains(searchedValue))
                  ingredientButton(
                      ingredient, Ingredients.values.indexOf(ingredient)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(120, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                "Cancella",
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(width: 5),
            OutlinedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(customItem!);
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(120, 20),
                backgroundColor: Colors.grey[350],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                "Conferma",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget ingredientButton(Ingredients ingredient, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: OutlinedButton(
        onPressed: () {
          addIngredients(ingredient);
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Text(
              capitalize(toStringIngredients(ingredient)),
              style: TextStyle(color: Colors.grey[800]),
            ),
            const SizedBox(width: 8),
            Text(
              "+€${costIngredients[ingredient]}",
              style: TextStyle(color: Colors.grey[600], fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
