import 'package:app_pizzeria/screen/detail_page.dart';
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navBar = NavBar(pageController: _pageController);
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          controller: _pageController,
          children: const <Widget>[
            Home(),
            DetailPage(),
          ],
        ),
      ),
      bottomNavigationBar: navBar,
    );
  }
}
