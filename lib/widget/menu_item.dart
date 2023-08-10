import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/categories_buttons_tab.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.pizzaImage,
      required this.pizza,
      required this.ingredients,
      required this.price,
      required this.category});

  final String pizzaImage;
  final String pizza;
  final String ingredients;
  final String price;
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
              padding: const EdgeInsets.only(left: 120.0, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                //color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pizza,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        ingredients,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "€$price",
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
                ))
          ],
        ),
      ),
    );
  }
}
