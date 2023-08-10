import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(this.width, this.title, this.image, this.action,{super.key, this.category});

  final double width;
  final String title;
  final String image;
  final void Function(int index, {Categories selectedCategory}) action;
  final Categories? category;

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
          onTap: () {

            if(category == null){
            action(1);}
            else {
              action(1, selectedCategory: category!);
            }
          },
        ),
      ),
    );
  }
}
