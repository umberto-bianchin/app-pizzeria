import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(this.width, this.title, this.image, {super.key});

  final double width;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 3.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0),
              )
            ],
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 229, 228, 228),
                Color.fromARGB(255, 243, 243, 243)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
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
                image: AssetImage(image),
                height: 80.0,
                width: 80.0,
              )
            ],
          ),
        ));
  }
}
