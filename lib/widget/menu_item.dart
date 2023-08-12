import 'package:app_pizzeria/data/menu_items_list.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/item_cart_add.dart';

import '../data/data_item.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.dataItem});

  final DataItem dataItem;

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
                            dataItem.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            dataItem.ingredients
                                .map((ingr) => toStringIngredients(ingr))
                                .join(', '),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      onTap: () {
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
                                    child: Text(dataItem.ingredients
                                        .map(
                                            (ingr) => toStringIngredients(ingr))
                                        .join(', ')),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "€${dataItem.initialPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15.0),
                      ),
                      IconButton(
                        onPressed: () {
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
                                      ),
                                      IconButton(
                                          icon: const Icon(Icons.close),
                                          color: const Color(0xFF1F91E7),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 20),
                                      child: ItemCart(dataItem: dataItem),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
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
                image: AssetImage(dataItem.image),
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
