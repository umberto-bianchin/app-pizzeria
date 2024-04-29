import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/providers/menu_provider.dart';
import 'package:app_pizzeria/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_pizzeria/widget/nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('NavBar navigates to the correct screen on tap',
      (WidgetTester tester) async {
    // Setup a MaterialApp to test navigation
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PageProvider()),
          ChangeNotifierProvider(create: (_) => CartItemsProvider()),
          ChangeNotifierProvider(create: (_) => MenuProvider()),

        ],
        child: const MaterialApp(
          home: NavBar(),
        )));

    // Find the Menu icon and tap it
    var menuIcon = find.byIcon(Icons.menu_book_rounded);
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    // Verify that we navigated to the Menu screen
    expect(find.text('Menu'), findsOneWidget);
  });
}
