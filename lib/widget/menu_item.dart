import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/categories_buttons_tab.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.pizzaImage,
      required this.name,
      required this.ingredients,
      required this.price,
      required this.category});

  final String pizzaImage;
  final String name;
  final List<String> ingredients;
  final double price;
  final Categories category;

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
                            name,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            ingredients.join(", "),
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
                                title: Text(
                                  name,
                                  textAlign: TextAlign.center,
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      ingredients.join(", "),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
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
                        "€${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15.0),
                      ),
                      IconButton(
                        onPressed: () {},
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
                image: AssetImage(pizzaImage),
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
