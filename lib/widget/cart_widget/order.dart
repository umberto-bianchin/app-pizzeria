import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    final bool confirmed = Provider.of<CartItemsProvider>(context).confirmed;
    final String time = Provider.of<CartItemsProvider>(context).time;

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
                  text: confirmed ? 'Confermato' : 'Da confermare',
                  style: TextStyle(
                    fontSize: 16,
                    color: confirmed ? Colors.green : Colors.red,
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
                  text: time == ""
                      ? "Riceverai presto aggiornamenti sull'orario"
                      : time.toString(),
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
