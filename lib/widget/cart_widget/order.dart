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
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color.fromARGB(255, 157, 199, 233).withOpacity(0.5)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Puoi modifcare l'ordine fino a che non viene accettato.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Status: ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(confirmed ? 'Confermato' : 'Da confermare',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: confirmed ? Colors.green : Colors.red)),
                const SizedBox(height: 10),
                Text(
                  'Orario: ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                    time == ""
                        ? "\tRiceverai presto aggiornamenti sull'orario"
                        : "\t$time",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
