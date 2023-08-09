import 'package:app_pizzeria/widget/suggested_tabs.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/categories_tabs.dart';
import 'package:app_pizzeria/widget/introduction_pizzeria.dart';
import 'package:app_pizzeria/widget/maps.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: ListView(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SearchBar(
              leading: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.search),
              ),
              trailing: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
              hintText: "Cerca quello che vuoi ordinare",
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          const IntroductionPizzeria(),
          const SizedBox(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text("Categorie",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          const CategoriesTabs(),
          const SizedBox(
            height: 15.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text("Suggeriti",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          const SuggestedTabs(),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 40,
            ),
            child: Text("Dove Siamo?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          const Maps(),
        ],
      ),
    );
  }
}
