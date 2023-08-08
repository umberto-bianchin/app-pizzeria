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
  int _currentPageIndex = 0;

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
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          children: const <Widget>[
            Home(),
            DetailPage(),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(pageController: _pageController),
    );
  }
}
