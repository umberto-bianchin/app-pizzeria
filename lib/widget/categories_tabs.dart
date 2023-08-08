import 'package:flutter/material.dart';

class CategoriesTabs extends StatelessWidget {
  const CategoriesTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 140.0,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            category(width, "Pizze", "assets/images/pizza.png"),
            category(width, "Kebab", "assets/images/mexican.png"),
            category(width, "Panini", "assets/images/burger.png")
          ],
        ),
      ),
    );
  }

  Widget category(double width, String title, String assetImage) {
    return Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: SizedBox(
          width: width / 3.3,
          child: Card(
            color: const Color.fromARGB(255, 246, 246, 246),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Image(
                  image: AssetImage(assetImage),
                  height: 80.0,
                  width: 80.0,
                )
              ],
            ),
          ),
        ));
  }
}
