import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/item_cart_add.dart';

import '../data/data_item.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.dataItem, required this.icon});

  final DataItem dataItem;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: SizedBox(
        height: 100.0,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 115.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            dataItem.menuDefault
                                ? dataItem.name
                                : "${dataItem.name}\n x${dataItem.quantity}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          if (dataItem.category != Categories.bibite)
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                  style: const TextStyle(color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: dataItem.ingredients
                                          .where((ingredient) =>
                                              !dataItem.addedIngredients[
                                                  dataItem.ingredients
                                                      .indexOf(ingredient)] &&
                                              dataItem.isSelected[dataItem
                                                  .ingredients
                                                  .indexOf(ingredient)])
                                          .map((ingr) => ingr)
                                          .join(', '),
                                    ),
                                    TextSpan(
                                      text:
                                          ", ${dataItem.ingredients.where((ingredient) => dataItem.addedIngredients[dataItem.ingredients.indexOf(ingredient)] && dataItem.isSelected[dataItem.ingredients.indexOf(ingredient)]).map((ingr) => ingr).join(', ')}",
                                      style: const TextStyle(
                                        color: Color(0xFF1F91E7),
                                      ),
                                    )
                                  ]),
                            ),
                        ],
                      ),
                      onTap: () {
                        if (dataItem.category != Categories.bibite) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  alignment: Alignment.center,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dataItem.name,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      IconButton(
                                          icon: const Icon(Icons.close),
                                          color: const Color(0xFF1F91E7),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 20, bottom: 20),
                                      child: Text(
                                        dataItem.ingredients
                                            .map((ingr) => ingr)
                                            .join(', '),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "€${dataItem.calculatePrice(context).toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15.0),
                      ),
                      IconButton(
                        onPressed: () {
                          if (icon != null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ItemCart(dataItem: dataItem);
                                });
                          }
                        },
                        icon: icon ??
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              left: 0.0,
              child: Image(
                image: dataItem.image,
                height: 100.0,
                width: 100.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
