import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  NavBar(
      {super.key,
      required this.onChangePage,
      required this.selectedIndex,
      required this.cartItemCount});

  final void Function(int index) onChangePage;
  final int selectedIndex;
  final int cartItemCount;

  final List<Pair> pairList = [
    Pair(Icons.home, "Home"),
    Pair(Icons.menu_book_rounded, "Menu"),
    Pair(Icons.shopping_cart, "Carrello"),
    Pair(Icons.person, "Utente"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 229, 228, 228),
              Color.fromARGB(255, 243, 243, 243)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (Pair pair in pairList)
            buildNavBarItem(pair.icon, pair.name, pairList.indexOf(pair)),
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, String name, int index) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color:
                            index == selectedIndex ? Colors.red : Colors.black,
                      ),
                      if (index == 2 && cartItemCount != 0)
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: index == selectedIndex
                                ? Colors.red
                                : Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            cartItemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: index == selectedIndex ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              onChangePage(index);
            },
          ),
        ),
      ),
    );
  }
}

class Pair {
  Pair(this.icon, this.name);
  IconData icon;
  String name;
}
