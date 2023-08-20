import 'package:app_pizzeria/data/data_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper.dart';
import '../../providers/cart_provider.dart';

class TotalPrice extends StatefulWidget {
  const TotalPrice({super.key});

  @override
  State<TotalPrice> createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemsProvider>(context);
    TimeOfDay? time;

    return Container(
      height: 50,
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
            cart.ordered
                ? 'Differenza: €${cart.difference().toStringAsFixed(2)}'
                : 'Totale:  €${context.watch<CartItemsProvider>().getTotal().toStringAsFixed(2)}',
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
              String deliveryMethod = "Asporto";
              bool isDelivery = false;

              await showCupertinoDialog(
                  context: context,
                  builder: ((context) {
                    return CupertinoAlertDialog(
                      title: const Text("Scegli come ritirare il tuo ordine"),
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Asporto",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Checkbox(
                                        activeColor: Colors.blue,
                                        value: !isDelivery,
                                        shape: const CircleBorder(),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isDelivery = !value!;
                                            deliveryMethod = "Asporto";
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Domicilio",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Checkbox(
                                        activeColor: Colors.blue,
                                        value: isDelivery,
                                        shape: const CircleBorder(),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isDelivery = value!;
                                            deliveryMethod = "Domicilio";
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            deliveryMethod = "";
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancella'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            Provider.of<CartItemsProvider>(context,
                                    listen: false)
                                .deliveryMethod = deliveryMethod;

                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Seleziona',
                            style: TextStyle(color: kprimaryColor),
                          ),
                        ),
                      ],
                    );
                  }));

              if (context.mounted && deliveryMethod != "") {
                time = await showTimePicker(
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
              }
              bool timeSelected = time == null ? false : true;
              bool orderSubmit = false;

              if (context.mounted && timeSelected && deliveryMethod != "") {
                await showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text(
                          "Il tuo orario",
                          style: TextStyle(fontSize: 20),
                        ),
                        content: const Text(
                          'Il tuo ordine potrà subire piccole variazioni di orario in base alla disponibilità della pizzeria, attendi che venga confermato',
                          style: TextStyle(fontSize: 16),
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
                                  timeInterval: time!.to24hours(), order: cart, deliveryMethod: deliveryMethod);

                              orderSubmit = true;
                              cart.submitOrder();

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
                          title: const Text("Ordine inviato!"),
                          content: const Text(
                            'Il tuo ordine è stato inviato, verrà presto confermato dalla pizzeria',
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
            child: Text(
              cart.ordered ? 'Modifica' : 'Ordina',
              style: const TextStyle(
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

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hr = hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hr:$min";
  }
}
