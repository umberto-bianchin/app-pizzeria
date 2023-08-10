import 'package:flutter/material.dart';

class IntroductionPizzeria extends StatelessWidget {
  const IntroductionPizzeria({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        height: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromRGBO(255, 248, 230, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width / 20, right: width / 20),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nome\nPizzeria",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(215, 153, 79, 1)),
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
      ),
    );
  }
}
