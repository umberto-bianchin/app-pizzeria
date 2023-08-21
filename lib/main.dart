import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/providers/facebook_provider.dart';
import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/providers/user_infos_provider.dart';
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
      ChangeNotifierProvider(create: (_) => UserInfoProvider()),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => FacebookSignInProvider()),
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

  MenuPage menuPage = const MenuPage(selectedCategory: Categories.pizza);

  void changePage(int index, {Categories? selectedCategory}) {
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(_selectedPage);

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

    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: const Color.fromARGB(255, 4, 167, 113),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontSize: 18),
            bodyMedium: TextStyle(fontSize: 20),
            bodySmall: TextStyle(fontSize: 16),

          
          )),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 167, 113),
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
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
