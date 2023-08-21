import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/providers/facebook_provider.dart';
import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/providers/page_provider.dart';
import 'package:app_pizzeria/providers/user_infos_provider.dart';
import 'package:app_pizzeria/screen/cart.dart';
import 'package:app_pizzeria/screen/menu.dart';
import 'package:app_pizzeria/screen/auth.dart';
import 'package:app_pizzeria/screen/verify_email.dart';
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
      ChangeNotifierProvider(create: (_) => PageProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final PageController _pageController = PageController();
  final ValueNotifier<int> selectedPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    selectedPage.value = Provider.of<PageProvider>(context).selectedPage;

    selectedPage.addListener(() {
      _pageController.jumpToPage(selectedPage.value);
    });
    MenuPage menuPage = MenuPage(
        selectedCategory: Provider.of<PageProvider>(context).selectedCategory);

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
          bodyLarge: TextStyle(fontSize: 20),
          bodyMedium: TextStyle(fontSize: 15),
          bodySmall: TextStyle(fontSize: 16),
        ),
      ),
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
              const Home(),
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
        bottomNavigationBar: const NavBar(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
