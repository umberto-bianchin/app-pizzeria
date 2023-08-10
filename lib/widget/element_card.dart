import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(this.width, this.title, this.image, {super.key});

  final double width;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8, right: 4),
      width: width / 3,
      child: Card(
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image(
                image: AssetImage(image),
                height: 80.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
