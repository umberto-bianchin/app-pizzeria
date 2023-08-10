import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/menu_item.dart';

const items = [
  MenuItem(
    pizzaImage: "assets/images/classic.png",
    pizza: "Classic",
    ingredients: "Tamota sauce, cheese",
    price: "6.99",
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/americana.png",
    pizza: "Americana",
    ingredients: "Base + Peperani",
    price: "7.99",
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/veg.png",
    pizza: "Vegetarian",
    ingredients: "Tamota,Onion and Corn",
    price: "4.99",
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/mexicanPizza.png",
    pizza: "Mexican",
    ingredients: "Mushroom + Chillies",
    price: "6.99",
    category: Categories.pizza,
  )
];

/*
class Item {
  Item(
      {required this.image,
      required this.name,
      required this.ingredients,
      required this.price,
      required this.category});

  String image;
  String name;
  List<String> ingredients;
  int price;
  String category;
} */
