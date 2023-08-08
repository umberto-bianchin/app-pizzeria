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

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: ListView(
            children: const [
              //Inizio via
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          "Via della pizzeria, Padova",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Fine via

              SizedBox(
                height: 20.0,
              ),

              //Inizio immagine pizzeria
              IntroductionPizzeria(),
              //Fine immagine pizzeria

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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.green,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.grey[400],
            ),
            label: "Ordine",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.grey[400],
            ),
            label: "Utente",
          ),
        ],
      ),
    );
  }
}
