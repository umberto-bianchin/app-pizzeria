import 'package:app_pizzeria/data/data_item.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
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
    Widget displayed = context.watch<CartItemsProvider>().cartList.isNotEmpty
        ? cartElements()
        : emptyMessage();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: kprimaryColor),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Carrello",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.shopping_bag_outlined,
                size: 30,
              ),
            ],
          ),
        ),
        displayed
      ],
    );
  }

  Widget cartElements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          width: double.infinity,
          child: ListView.builder(
              itemCount: context.watch<CartItemsProvider>().cartList.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 25,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      Provider.of<CartItemsProvider>(context, listen: false)
                          .removeItem(Provider.of<CartItemsProvider>(context,
                                  listen: false)
                              .cartList[index]);
                    }
                  },
                  direction: DismissDirection.endToStart,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MenuItem(
                      dataItem:
                          context.watch<CartItemsProvider>().cartList[index],
                      icon: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                );
              }),
        ),
        const TotalPrice(),
      ],
    );
  }

  Widget emptyMessage() {
    return const Column(
      children: [
        SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Aggiungi qualcosa al carrello per poterlo visualizzare in questa pagina.",
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
