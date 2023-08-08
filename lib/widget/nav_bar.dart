import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.pageController});

  final PageController pageController;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<Pair> pairList = [
    Pair(Icons.home, "Home"),
    Pair(Icons.menu_book_rounded, "Menu"),
    Pair(Icons.shopping_basket, "Carrello"),
    Pair(Icons.person, "Utente"),
  ];

  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 229, 228, 228),
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
      color: const Color.fromARGB(255, 229, 228, 228),
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
                  Icon(
                    icon,
                    color: index == _selectedIndex ? Colors.red : Colors.black,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color:
                          index == _selectedIndex ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              _selectPage(index);
              widget.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
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
