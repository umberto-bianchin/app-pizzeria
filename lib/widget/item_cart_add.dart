import 'package:app_pizzeria/data/menu_items_list.dart';
import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:app_pizzeria/widget/quantity_selector.dart';
import 'package:app_pizzeria/widget/search_ingredient.dart';
import 'package:flutter/material.dart';

class ItemCart extends StatefulWidget {
  const ItemCart({super.key, required this.menuItem});

  final MenuItem menuItem;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  List<bool> isCheck = [];
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    isCheck.addAll(List.filled(widget.menuItem.ingredients.length, true));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(widget.menuItem.image),
              height: 100.0,
              width: 100.0,
            ),
            NumericStepButton(onChanged: (int x) {}),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          "Ingredienti:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 1.5,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Scrollbar(
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < isCheck.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(capitalize(toStringIngredients(
                              widget.menuItem.ingredients[i]))),
                          SizedBox(
                            height: 40,
                            child: Checkbox(
                              activeColor: Colors.blue,
                              value: isCheck[i],
                              shape: const CircleBorder(),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheck[i] = value!;
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
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          child: const SearchIngredient(),
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
                if (!widget.menuItem.ingredients.contains(ingredient))
                  ingredienButton(
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
              onPressed: () {},
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

  Widget ingredienButton(Ingredients ingredient, int index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: OutlinedButton(
            onPressed: () {},
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
            )));
  }
}
