import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Pair> listCategories = [
    Pair("pizza.png", "Pizza"),
    Pair("drink.png", "Panini"),
    Pair("drink.png", "Kebab"),
    Pair("drink.png", "Bibite"),
  ];

  int _selected = 0;

  void _selectCategory(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 10.0),
          child: Text(
            "Menu",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 40.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 15, right: 10),
            children: [
              for (Pair pair in listCategories)
                category(
                    listCategories.indexOf(pair) == _selected
                        ? Colors.green
                        : Colors.grey,
                    pair.name,
                    pair.icon,
                    listCategories.indexOf(pair) == _selected
                        ? Colors.white
                        : Colors.black,
                    listCategories.indexOf(pair)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: ListView(
            shrinkWrap: true,
            children: const [
              MenuItem(
                  pizzaImage: "assets/images/classic.png",
                  pizza: "Classic",
                  ingredients: "Tamota sauce, cheese",
                  price: "6.99"),
              MenuItem(
                  pizzaImage: "assets/images/americana.png",
                  pizza: "Americana",
                  ingredients: "Base + Peperani",
                  price: "7.99"),
              MenuItem(
                  pizzaImage: "assets/images/veg.png",
                  pizza: "Vegetarian",
                  ingredients: "Tamota,Onion and Corn",
                  price: "4.99"),
              MenuItem(
                  pizzaImage: "assets/images/mexicanPizza.png",
                  pizza: "Mexican",
                  ingredients: "Mushroom + Chillies",
                  price: "6.99")
            ],
          ),
        )
      ],
    );
  }

  Widget category(
      Color colore, String menu, String menuImage, Color menuColor, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          height: 40.0,
          width: 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: colore),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/$menuImage"),
                height: 20.0,
                width: 20.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(menu,
                  style: TextStyle(
                    color: menuColor,
                  ))
            ],
          ),
        ),
        onTap: () {
          _selectCategory(index);
        },
      ),
    );
  }
}

class Pair {
  Pair(this.icon, this.name);

  String icon;
  String name;
}
