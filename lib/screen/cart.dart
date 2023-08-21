import 'package:app_pizzeria/widget/cart_widget/order.dart';
import 'package:app_pizzeria/widget/user_widget/top_screen.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:app_pizzeria/widget/user_widget/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widget/cart_widget/total_price.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemsProvider>(context);

    Widget displayed =
        (cart.cartList.isNotEmpty && !cart.ordered) || cart.ordered
            ? cartElements()
            : emptyMessage();

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

  Widget cartElements() {
    final cart = Provider.of<CartItemsProvider>(context);

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
          if (!cart.confirmed &&
              ((cart.cartList.isNotEmpty && !cart.ordered) || cart.modified))
            const Align(
              alignment: Alignment.bottomCenter,
              child: TotalPrice(),
            )
        ],
      ),
    );
  }

  Widget emptyMessage() {
    return Column(
      children: [
        const SizedBox(height: 50),
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
