import 'package:flutter/material.dart';

import '../../data/data_item.dart';

class IntroductionPizzeria extends StatelessWidget {
  const IntroductionPizzeria({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 200.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: kprimaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(left: width / 20, right: width / 20),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pizzeria\n\tAntonino",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: width / 2.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/pizzeria.png"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
