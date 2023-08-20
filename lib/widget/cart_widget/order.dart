import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemsProvider>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Puoi modifcare l\'ordine fino a che non viene accettato',
            style: TextStyle(fontSize: 18),
          ),
          RichText(
            text: TextSpan(
              text: 'Status: ',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: cart.confirmed ? 'Confermato' : 'Da confermare',
                  style: TextStyle(
                    fontSize: 16,
                    color: cart.confirmed ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Orario: ',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: cart.time == ""
                      ? "Riceverai presto aggiornamenti sull'orario"
                      : cart.time.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
