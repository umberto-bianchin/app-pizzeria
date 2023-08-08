import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SlidingUpPanel(
          maxHeight: height,
          minHeight: height / 1.6,
          body: Container(
            height: height / 2,
            width: width,
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Image(
                  image: const NetworkImage("https://rb.gy/lj2eiu"),
                  fit: BoxFit.cover,
                  height: height / 2,
                  width: width,
                ),
                Positioned(
                    top: 40.0,
                    left: 15.0,
                    child: IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 35.0,
                        ),
                        onPressed: () => Navigator.of(context).pop(true)))
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.grey,
          panel: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Pizzeria Di Mora",
                      style: TextStyle(
                          fontSize: 26.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("4.6",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                child: Text(
                  "Italian - 4.9km - \$-\$\$",
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 40.0,
                width: width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    menu(Colors.green, "Pizza", "assets/images/pizza.png",
                        Colors.white),
                    menu(Colors.grey, "Drinks", "assets/images/drink.png",
                        Colors.black),
                    menu(Colors.grey, "Snacks", "assets/images/snack.png",
                        Colors.black),
                    menu(Colors.grey, "Pastry", "assets/images/pastry.png",
                        Colors.black)
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                  child: Column(
                    children: [
                      menuItemtab("assets/images/classic.png", "Classic",
                          "Tamota sauce, cheese", "6.99"),
                      menuItemtab("assets/images/americana.png", "Americana",
                          "Base + Peperani", "7.99"),
                      menuItemtab("assets/images/veg.png", "Vegetarian",
                          "Tamota,Onion and Corn", "4.99"),
                      menuItemtab("assets/images/mexicanPizza.png", "Mexican",
                          "Mushroom + Chillies", "6.99")
                    ],
                  ))
            ],
          )),
    );
  }

  Widget menuItemtab(
      String pizzaImage, String pizza, String ingredients, String price) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: SizedBox(
        height: 100.0,
        width: width - 40.0,
        child: Stack(
          children: [
            //let have the clok for the pizza items....
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Container(
                padding: const EdgeInsets.only(left: 70.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                height: 100.0,
                width: width - 90.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pizza,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          ingredients,
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Text("\$$price",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 15.0))
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0.0,
                child: Image(
                  image: AssetImage(pizzaImage),
                  height: 100.0,
                  width: 100.0,
                ))
          ],
        ),
      ),
    );
  }

  Widget menu(Color colore, String menu, String menuImage, Color menuColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
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
              image: AssetImage(menuImage),
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
    );
  }
}
