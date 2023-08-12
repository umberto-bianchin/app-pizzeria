import 'package:app_pizzeria/data/data_item.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widget/total_price.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: kprimaryColor),
          child: const Text(
            "Carrello",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          width: double.infinity,
          child: ListView.builder(
              itemCount: context.watch<CartItemsProvider>().cartList.length,
              itemBuilder: (ctx, index) {
                if (context.watch<CartItemsProvider>().cartList.isEmpty) {
                  //TODO
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MenuItem(
                    dataItem:
                        context.watch<CartItemsProvider>().cartList[index],
                    icon: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                  ),
                );
              }),
        ),
        const TotalPrice(),
      ],
    );
  }
}
