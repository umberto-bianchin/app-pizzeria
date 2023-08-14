import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.width, this.title, this.image, this.action,
      {super.key, this.category});

  final double width;
  final String title;
  final String image;
  final void Function(int index, {Categories selectedCategory}) action;
  final Categories? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8, right: 4),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image(
                image: AssetImage(image),
                height: 60.0,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
        onPressed: () {
          action(1, selectedCategory: category!);
        },
      ),
    );
  }
}
