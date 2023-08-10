import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/menu_item.dart';

const items = [
  MenuItem(
    pizzaImage: "assets/images/classic.png",
    name: "Margherita",
    ingredients: ["pomodoro", "mozzarella"],
    price: 6.99,
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/americana.png",
    name: "Diavola",
    ingredients: ["pomodoro", "mozzarella", "salamino piccante"],
    price: 7.99,
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/veg.png",
    name: "Vegetariana",
    ingredients: ["pomodoro", "mozzarella", "verdure al forno"],
    price: 4.99,
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/mexicanPizza.png",
    name: "Prosciutto e Funghi",
    ingredients: ["pomodoro", "mozzarella", "cotto", "funghi"],
    price: 6.99,
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/mexicanPizza.png",
    name: "Bea",
    ingredients: [
      "pomodoro",
      "mozzarella",
      "cotto",
      "salsiccia",
      "salamino",
      "piselli",
      "peperoni",
      "zucchine",
      "grana"
    ],
    price: 9,
    category: Categories.pizza,
  ),
  MenuItem(
    pizzaImage: "assets/images/mexicanPizza.png",
    name: "Tonno e Cipolla",
    ingredients: ["pomodoro", "mozzarella", "tonno", "cipolla"],
    price: 6.99,
    category: Categories.pizza,
  )
];
