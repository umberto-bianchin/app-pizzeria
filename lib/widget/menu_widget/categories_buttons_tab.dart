import 'package:flutter/material.dart';

enum Categories {
  pizza,
  bibite,
  panini,
  kebab,
}

class CategoriesButton extends StatefulWidget {
  const CategoriesButton(this.initialCategory, this.onCategorychange,
      {super.key});

  final Categories initialCategory;
  final Function(Categories) onCategorychange;

  @override
  State<CategoriesButton> createState() => _CategoriesButtonState();
}

class _CategoriesButtonState extends State<CategoriesButton> {
  List<Pair> listCategories = [
    Pair("pizza.png", Categories.pizza),
    Pair("mexican.png", Categories.kebab),
    Pair("burger.png", Categories.panini),
    Pair("drink.png", Categories.bibite),
  ];

  Categories? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialCategory;
  }

  void _selectCategory(Categories category) {
    widget.onCategorychange(category);
    setState(() {
      _selected = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 10),
        children: [
          for (Pair pair in listCategories)
            category(
                pair.category == _selected ? Theme.of(context).primaryColor : Colors.grey,
                pair.category,
                pair.icon,
                pair.category == _selected ? Colors.white : Colors.black,
                listCategories.indexOf(pair)),
        ],
      ),
    );
  }

  Widget category(Color colore, Categories nameCat, String menuImage,
      Color menuColor, int index) {
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
              Text(
                capitalize(nameCat.name),
                style: TextStyle(
                  color: menuColor,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          _selectCategory(nameCat);
        },
      ),
    );
  }
}

String capitalize(String value) {
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

class Pair {
  Pair(this.icon, this.category);

  String icon;
  Categories category;
}
