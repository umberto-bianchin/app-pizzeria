import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/screen/cart.dart';
import 'package:app_pizzeria/screen/menu.dart';
import 'package:app_pizzeria/screen/auth.dart';
import 'package:app_pizzeria/screen/verify_email.dart';
import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/screen/home.dart';
import 'package:provider/provider.dart';
import 'data/data_item.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartItemsProvider()),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
    ],
    child: const MyApp(),
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
  int cartItemCount = 0;

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
    cartItemCount = Provider.of<CartItemsProvider>(context).element;
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kprimaryColor,
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: false,
            controller: _pageController,
            children: [
              Home(onSelectCategory: changePage),
              menuPage,
              const CartScreen(),
              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text("Exception");
                    } else if (snapshot.hasData) {
                      return const VerifyEmailScreen();
                    } else {
                      return const AuthScreen();
                    }
                  }),
            ],
          ),
        ),
        bottomNavigationBar: NavBar(
          onChangePage: changePage,
          selectedIndex: _selectedPage,
          cartItemCount: cartItemCount,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
