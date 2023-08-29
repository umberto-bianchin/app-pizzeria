import 'package:app_pizzeria/helper.dart';
import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/widget/user_widget/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    final bool confirmed = Provider.of<CartItemsProvider>(context).confirmed;
    final String time = Provider.of<CartItemsProvider>(context).time;
    final deliveryPrice = Provider.of<CartItemsProvider>(context).deliveryPrice;

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
                  confirmed
                      ? "Il tuo ordine è stato accettato, se vuoi modificarlo contatta la pizzeria"
                      : "Puoi modificare l'ordine fino a che non viene accettato.",
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
                  confirmed
                      ? time
                      : "Riceverai presto aggiornamenti sull'orario",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Costo consegna: ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                    confirmed
                        ? '€ $deliveryPrice'
                        : 'Riceverai presto aggiornamenti',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                        )),
                const SizedBox(height: 10),
                if (!confirmed)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        deleteOrder(context);
                        MySnackBar.showMySnackBar(context, "Ordine cancellato");
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        surfaceTintColor: Colors.white60,
                      ),
                      child: Text(
                        "Cancella ordine",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
