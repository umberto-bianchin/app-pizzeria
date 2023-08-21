import 'package:app_pizzeria/data/menu_items_list.dart';
import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/user_widget/my_snackbar.dart';
import 'package:app_pizzeria/widget/quantity_selector.dart';
import 'package:app_pizzeria/widget/search_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data_item.dart';
import '../providers/cart_provider.dart';

class ItemCart extends StatefulWidget {
  const ItemCart({super.key, required this.dataItem});

  final DataItem dataItem;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
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
      if (!customItem!.menuDefault) {
        context
            .read<CartItemsProvider>()
            .changeIngredient(customItem!, i, value);
      } else {
        customItem!.isSelected[i] = value;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.dataItem.menuDefault) {
      customItem = widget.dataItem.copy();
    } else {
      customItem = widget.dataItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool confirmed = context.watch<CartItemsProvider>().confirmed;

    if (confirmed) {
      return const Text(
        "L'ordine è stato confermato. Non è possibile modificarlo.",
        style: TextStyle(fontSize: 16),
      );
    }

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
            NumericStepButton(
              onChanged: setQuantity,
              minValue: customItem!.menuDefault ? 1 : 0,
              initialValue: customItem!.quantity,
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (customItem!.category != Categories.bibite)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          for (int i = 0;
                              i < customItem!.ingredients.length;
                              i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  capitalize(
                                    toStringIngredients(
                                        customItem!.ingredients[i]),
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Checkbox(
                                      activeColor: Colors.blue,
                                      value: customItem!.isSelected[i],
                                      shape: const CircleBorder(),
                                      onChanged: (bool? value) {
                                        setChecked(i, value!);
                                      }),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
        if (customItem!.category != Categories.bibite)
          Column(
            children: [
              const SizedBox(height: 10),
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
                          toStringIngredients(ingredient)
                              .contains(searchedValue))
                        ingredientButton(
                            ingredient, Ingredients.values.indexOf(ingredient)),
                  ],
                ),
              ),
            ],
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
                "Chiudi",
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(width: 5),
            OutlinedButton(
              onPressed: () {
                if (customItem!.menuDefault) {
                  context.read<CartItemsProvider>().addItem(customItem!);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  MySnackBar.showMySnackBar(context, "Aggiunto al carrello");
                } else {
                  context
                      .read<CartItemsProvider>()
                      .changeQuantity(customItem!, quantity);

                  if (quantity == 0) {
                    context.read<CartItemsProvider>().removeItem(customItem!);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    MySnackBar.showMySnackBar(context, "Rimosso dal carrello");
                  }
                }
                Navigator.pop(context);
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
