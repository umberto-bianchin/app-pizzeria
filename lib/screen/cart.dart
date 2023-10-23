/// This file contains the code for the Cart Screen of the Flutter app.
///
/// The [CartScreen] class is a stateless widget that displays the user's cart
/// with items they have added for ordering. It also allows users to remove items
/// from the cart.
///
///
/// The [build] method returns a Column widget with a [TopBanner], an [Order] widget
/// (if the order is confirmed), and the cart elements (items in the cart).
///
/// The [cartElements] method builds the UI for the items in the cart. It uses a
/// ListView.builder to display each item. It also includes functionality to allow
/// the user to remove items from the cart.
///
/// The [emptyMessage] method provides a message to be displayed when the cart is empty.
///
///

import 'package:app_pizzeria/providers/menu_provider.dart';
import 'package:app_pizzeria/widget/cart_widget/order.dart';
import 'package:app_pizzeria/widget/user_widget/top_screen.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:app_pizzeria/widget/user_widget/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widget/cart_widget/total_price.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemsProvider>(context);
    Provider.of<MenuProvider>(context);

    Widget displayed =
        (cart.cartList.isNotEmpty && !cart.ordered) || cart.ordered
            ? cartElements(cart, context)
            : emptyMessage(context);

    return Column(
      children: [
        TopBanner(
          title: cart.ordered ? 'Il tuo ordine' : 'Carrello',
          icon: cart.ordered ? Icons.list_alt : Icons.shopping_bag_outlined,
        ),
        if (cart.ordered) const Order(),
        displayed,
      ],
    );
  }

  Widget cartElements(CartItemsProvider cart, BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            top: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 20.0, 0.0),
              child: ListView.builder(
                  itemCount: cart.cartList.length,
                  itemBuilder: (ctx, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        margin: const EdgeInsets.symmetric(
                          vertical: 25,
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Trascina per eliminare',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          cart.removeItem(cart.cartList[index]);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          MySnackBar.showMySnackBar(
                              context, "Rimosso dal carrello");
                        }
                      },
                      direction: cart.confirmed
                          ? DismissDirection.none
                          : DismissDirection.endToStart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: MenuItem(
                          dataItem: cart.cartList[index],
                          icon: cart.confirmed
                              ? null
                              : const Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: TotalPrice(),
          )
        ],
      ),
    );
  }

  Widget emptyMessage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        if (Provider.of<CartItemsProvider>(context, listen: false).rejected)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Il tuo ordine è stato rifiutato a causa dell'elevata richiesta",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      Provider.of<CartItemsProvider>(context, listen: false)
                          .clearRejection();
                    },
                    child: const Text("OK"))
              ],
            ),
          ),
        if (!Provider.of<CartItemsProvider>(context, listen: false).rejected)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Aggiungi qualcosa al carrello per poterlo visualizzare in questa pagina.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
      ],
    );
  }
}
