import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class TotalPrice extends StatefulWidget {
  const TotalPrice({super.key});

  @override
  State<TotalPrice> createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.4,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 87, 87, 87),
              Color.fromARGB(255, 153, 153, 153)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Totale: ${context.watch<CartItemsProvider>().getTotal().toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0))),
              side: MaterialStateProperty.all(
                const BorderSide(
                    color: Colors.black, width: 1.0, style: BorderStyle.solid),
              ),
              backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
              foregroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.black),
              shadowColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
            ),
            onPressed: () {},
            child: const Text(
              'Ordina',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
