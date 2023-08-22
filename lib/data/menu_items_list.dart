import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:app_pizzeria/data/data_item.dart';
import 'package:flutter/material.dart';

const Color _kprimaryColor = Color.fromARGB(255, 4, 167, 113);

var items = [
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Margherita"]![2],
      name: "Margherita",
      ingredients: [Ingredients.pomodoro, Ingredients.mozzarella],
      initialPrice: information["Margherita"]![0],
      category: information["Margherita"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Diavola"]![2],
      name: "Diavola",
      ingredients: [
        Ingredients.pomodoro,
        Ingredients.mozzarella,
        Ingredients.salamino_piccante
      ],
      initialPrice: information["Diavola"]![0],
      category: information["Diavola"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Vegetariana"]![2],
      name: "Vegetariana",
      ingredients: [
        Ingredients.pomodoro,
        Ingredients.mozzarella,
        Ingredients.verdure_al_forno
      ],
      initialPrice: information["Vegetariana"]![0],
      category: information["Vegetariana"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Prosciutto e Funghi"]![2],
      name: "Prosciutto e Funghi",
      ingredients: [
        Ingredients.pomodoro,
        Ingredients.mozzarella,
        Ingredients.cotto,
        Ingredients.funghi
      ],
      initialPrice: information["Prosciutto e Funghi"]![0],
      category: information["Prosciutto e Funghi"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Bea"]![2],
      name: "Bea",
      ingredients: [
        Ingredients.pomodoro,
        Ingredients.mozzarella,
        Ingredients.cotto,
        Ingredients.salsiccia,
        Ingredients.salamino,
        Ingredients.piselli,
        Ingredients.peperoni,
        Ingredients.gorgonzola,
        Ingredients.grana
      ],
      initialPrice: information["Bea"]![0],
      category: information["Bea"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Tonno e Cipolla"]![2],
      name: "Tonno e Cipolla",
      ingredients: [
        Ingredients.pomodoro,
        Ingredients.mozzarella,
        Ingredients.tonno,
        Ingredients.cipolla
      ],
      initialPrice: information["Tonno e Cipolla"]![0],
      category: information["Tonno e Cipolla"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Wurstel"]![2],
      name: "Wurstel",
      ingredients: [
        Ingredients.pomodoro,
        Ingredients.mozzarella,
        Ingredients.wustel
      ],
      initialPrice: information["Wurstel"]![0],
      category: information["Wurstel"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["A4"]![2],
      name: "A4",
      ingredients: [
        Ingredients.mozzarella,
        Ingredients.salsiccia,
        Ingredients.cipolla,
        Ingredients.gorgonzola,
        Ingredients.funghi
      ],
      initialPrice: information["A4"]![0],
      category: information["A4"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Coca Cola"]![2],
      name: "Coca Cola",
      ingredients: [],
      initialPrice: information["Coca Cola"]![0],
      category: information["Coca Cola"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  ),
  MenuItem(
    dataItem: DataItem(
      key: UniqueKey(),
      image: information["Acqua"]![2],
      name: "Acqua",
      ingredients: [],
      initialPrice: information["Acqua"]![0],
      category: information["Acqua"]![1],
    ),
    icon: const Icon(
      Icons.add_shopping_cart,
      color: _kprimaryColor,
    ),
  )
];

enum Ingredients {
  pomodoro,
  mozzarella,
  cotto,
  salsiccia,
  salamino,
  piselli,
  peperoni,
  zucchine,
  grana,
  funghi,
  cipolla,
  gorgonzola,
  wustel,
  tonno,
  salamino_piccante,
  verdure_al_forno,
}

String toStringIngredients(Ingredients ingredient) {
  return ingredient.name.replaceAll("_", " ");
}

Map<String, List<dynamic>> information = {
  "Margherita": [6.99, Categories.pizza, "assets/images/classic.png"],
  "Diavola": [7.99, Categories.pizza, "assets/images/americana.png"],
  "Vegetariana": [4.99, Categories.pizza, "assets/images/veg.png"],
  "Prosciutto e Funghi": [
    6.99,
    Categories.pizza,
    "assets/images/mexicanPizza.png"
  ],
  "Bea": [9.0, Categories.pizza, "assets/images/mexicanPizza.png"],
  "Tonno e Cipolla": [6.99, Categories.pizza, "assets/images/mexicanPizza.png"],
  "Wurstel": [14.0, Categories.kebab, "assets/images/pizza.png"],
  "A4": [6.5, Categories.panini, "assets/images/burger.png"],
  "Coca Cola": [2.0, Categories.bibite, "assets/images/drink.png"],
  "Acqua": [1.0, Categories.bibite, "assets/images/drink.png"],
};

Map<Ingredients, double> costIngredients = {
  Ingredients.pomodoro: 0.55,
  Ingredients.mozzarella: 0.55,
  Ingredients.cotto: 0.55,
  Ingredients.salsiccia: 0.55,
  Ingredients.salamino: 0.55,
  Ingredients.piselli: 0.55,
  Ingredients.peperoni: 0.55,
  Ingredients.zucchine: 0.55,
  Ingredients.grana: 0.55,
  Ingredients.funghi: 0.55,
  Ingredients.cipolla: 0.55,
  Ingredients.gorgonzola: 0.55,
  Ingredients.wustel: 0.55,
  Ingredients.tonno: 0.55,
  Ingredients.salamino_piccante: 0.55,
  Ingredients.verdure_al_forno: 0.55,
};
