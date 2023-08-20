import 'package:app_pizzeria/data/data_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper.dart';
import '../../providers/cart_provider.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.4,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Totale:  €${context.watch<CartItemsProvider>().getTotal().toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              side: const BorderSide(
                color: Colors.white,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              shadowColor: Colors.transparent,
            ),
            onPressed: () async {
              final time = await showTimePicker(
                  initialEntryMode: TimePickerEntryMode.inputOnly,
                  cancelText: "Cancella",
                  confirmText: "Conferma",
                  hourLabelText: "Ora",
                  minuteLabelText: "Minuti",
                  errorInvalidText: "Inserisci un orario valido",
                  helpText: "Inserisci l'orario di consegna desiderato",
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, childWidget) {
                    return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: childWidget!);
                  });

              bool timeSelected = time == null ? false : true;
              bool orderSubmit = false;

              if (context.mounted && timeSelected) {
                await showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text(
                          "Il tuo orario",
                          style: TextStyle(fontSize: 20),
                        ),
                        content: Text(
                          'Il tuo ordine sarà disponibile in un intervallo di 30 minuti a partire dalle ${time.format(context)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancella'),
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              final cart = Provider.of<CartItemsProvider>(
                                  context,
                                  listen: false);

                              submitOrder(context,
                                  timeInterval: time.format(context),
                                  order: cart.cart);

                              orderSubmit = true;
                              cart.clearCart();

                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Ordina',
                              style: TextStyle(color: kprimaryColor),
                            ),
                          ),
                        ],
                      );
                    });
              }
              if (context.mounted) {
                if (orderSubmit) {
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text("Ordine confermato!"),
                          content: const Text(
                            'Il tuo ordine è stato confermato, verrà presto accettato dalla pizzeria\nSe vuoi modificarlo o cancellarlo vai nella sezione Utente -> Il mio ordine',
                            style: TextStyle(fontSize: 12),
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        );
                      });
                }
              }
            },
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
