import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/menu_item.dart';

const items = [
  MenuItem(
    image: "assets/images/classic.png",
    name: "Margherita",
    ingredients: ["pomodoro", "mozzarella"],
    price: 6.99,
    category: Categories.pizza,
  ),
  MenuItem(
    image: "assets/images/americana.png",
    name: "Diavola",
    ingredients: ["pomodoro", "mozzarella", "salamino piccante"],
    price: 7.99,
    category: Categories.pizza,
  ),
  MenuItem(
    image: "assets/images/veg.png",
    name: "Vegetariana",
    ingredients: ["pomodoro", "mozzarella", "verdure al forno"],
    price: 4.99,
    category: Categories.pizza,
  ),
  MenuItem(
    image: "assets/images/mexicanPizza.png",
    name: "Prosciutto e Funghi",
    ingredients: ["pomodoro", "mozzarella", "cotto", "funghi"],
    price: 6.99,
    category: Categories.pizza,
  ),
  MenuItem(
    image: "assets/images/mexicanPizza.png",
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
    image: "assets/images/mexicanPizza.png",
    name: "Tonno e Cipolla",
    ingredients: ["pomodoro", "mozzarella", "tonno", "cipolla"],
    price: 6.99,
    category: Categories.pizza,
  ),
  MenuItem(
    image: "assets/images/pizza.png",
    name: "Wurstel",
    ingredients: ["pomodoro", "mozzarella", "wurstel"],
    price: 14,
    category: Categories.panari,
  ),
  MenuItem(
    image: "assets/images/burger.png",
    name: "A4",
    ingredients: ["mozzarella", "salsiccia", "cipolla", "gorgonzola", "funghi"],
    price: 6.5,
    category: Categories.panini,
  ),
  MenuItem(
    image: "assets/images/drink.png",
    name: "Coca Cola",
    ingredients: [],
    price: 2,
    category: Categories.bibite,
  ),
  MenuItem(
    image: "assets/images/drink.png",
    name: "Acqua",
    ingredients: [],
    price: 1,
    category: Categories.bibite,
  )
];
