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
        children: const [
          SizedBox(
            height: 40.0,
          ),
          IntroductionPizzeria(),
          SizedBox(
            height: 10.0,
          ),

          //Inizio Categorie
          Padding(
            padding: EdgeInsets.all(
              20.0,
            ),
            child: Text("Categorie",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          CategoriesTabs(),
          //Fine Categorie

          Padding(
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
          Maps(),
        ],
      ),
    );
  }
}
