import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:app_pizzeria/data/data_item.dart';
import 'package:flutter/material.dart';

var items = [
  MenuItem(
      dataItem: DataItem(
          key: UniqueKey(),
          image: "assets/images/classic.png",
          name: "Margherita",
          ingredients: [Ingredients.pomodoro, Ingredients.mozzarella],
          initialPrice: 6.99,
          category: Categories.pizza)),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/americana.png",
    name: "Diavola",
    ingredients: [
      Ingredients.pomodoro,
      Ingredients.mozzarella,
      Ingredients.salamino_piccante
    ],
    initialPrice: 7.99,
    category: Categories.pizza,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/veg.png",
    name: "Vegetariana",
    ingredients: [
      Ingredients.pomodoro,
      Ingredients.mozzarella,
      Ingredients.verdure_al_forno
    ],
    initialPrice: 4.99,
    category: Categories.pizza,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/mexicanPizza.png",
    name: "Prosciutto e Funghi",
    ingredients: [
      Ingredients.pomodoro,
      Ingredients.mozzarella,
      Ingredients.cotto,
      Ingredients.funghi
    ],
    initialPrice: 6.99,
    category: Categories.pizza,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/mexicanPizza.png",
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
    initialPrice: 9,
    category: Categories.pizza,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/mexicanPizza.png",
    name: "Tonno e Cipolla",
    ingredients: [
      Ingredients.pomodoro,
      Ingredients.mozzarella,
      Ingredients.tonno,
      Ingredients.cipolla
    ],
    initialPrice: 6.99,
    category: Categories.pizza,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/pizza.png",
    name: "Wurstel",
    ingredients: [
      Ingredients.pomodoro,
      Ingredients.mozzarella,
      Ingredients.wustel
    ],
    initialPrice: 14,
    category: Categories.panari,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/burger.png",
    name: "A4",
    ingredients: [
      Ingredients.mozzarella,
      Ingredients.salsiccia,
      Ingredients.cipolla,
      Ingredients.gorgonzola,
      Ingredients.funghi
    ],
    initialPrice: 6.5,
    category: Categories.panini,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/drink.png",
    name: "Coca Cola",
    ingredients: [],
    initialPrice: 2,
    category: Categories.bibite,
  )),
  MenuItem(
      dataItem: DataItem(
    key: UniqueKey(),
    image: "assets/images/drink.png",
    name: "Acqua",
    ingredients: [],
    initialPrice: 1,
    category: Categories.bibite,
  ))
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
