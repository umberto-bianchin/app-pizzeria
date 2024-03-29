/// This file serves as the entry point for the Flutter application.
///
/// It imports necessary packages and files, including providers, screens, and widgets.
/// It initializes Firebase, sets preferred device orientations, and establishes the
/// root widget for the application.
///
/// The [MyApp] class is the root widget of the application. It configures theme data,
/// sets up providers for various features like user information, cart items, and more.
///
/// The [signIn] function handles user authentication using Firebase Authentication.
/// The [resetPassword] function handles the password reset process.
///
///
library;

import 'package:app_pizzeria/helper.dart';
import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/providers/facebook_provider.dart';
import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/providers/menu_provider.dart';
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
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// A global key for the navigator to be used for navigation outside of widgets.
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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
      ChangeNotifierProvider(create: (_) => MenuProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Page controller for managing pages.
  final PageController _pageController = PageController();
  // Value notifier to keep track of the selected page.
  final ValueNotifier<int> selectedPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).updateMenu(context);
    selectedPage.value = Provider.of<PageProvider>(context).selectedPage;

    // Listener to update the page when the selected page changes.
    selectedPage.addListener(() {
      _pageController.jumpToPage(selectedPage.value);
    });

    MenuPage menuPage = MenuPage(
        selectedCategory: Provider.of<PageProvider>(context).selectedCategory);

    // Listening for changes in the authentication state.
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (FirebaseAuth.instance.currentUser != null) {
        Provider.of<UserInfoProvider>(context, listen: false).getUser(context);
        if (Provider.of<CartItemsProvider>(context, listen: false)
            .cartList
            .isEmpty) {
          retrieveOrder(context);
        }
      }
    });

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
