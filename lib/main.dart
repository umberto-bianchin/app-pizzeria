import 'package:app_pizzeria/screen/menu.dart';
import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/screen/home.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: "Gilroy",
    ),
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageController _pageController = PageController();
  int _selectedPage = 0;

  MenuPage menuPage = const MenuPage(selectedCategory: Categories.pizza);

  void changePage(int index, {Categories? selectedCategory}) {
    setState(() {
      _selectedPage = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      if (selectedCategory != null) {
        menuPage = MenuPage(selectedCategory: selectedCategory);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          controller: _pageController,
          children: [Home(onSelectCategory: changePage), menuPage],
        ),
      ),
      bottomNavigationBar:
          NavBar(onChangePage: changePage, selectedIndex: _selectedPage),
    );
  }
}
