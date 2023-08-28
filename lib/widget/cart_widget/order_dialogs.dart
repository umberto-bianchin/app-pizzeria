import 'package:app_pizzeria/screen/user_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper.dart';
import '../../providers/cart_provider.dart';
import '../../providers/user_infos_provider.dart';
import '../user_widget/my_snackbar.dart';

class OrderDialogs {
  OrderDialogs({required this.context});
  String deliveryMethod = "Asporto";
  TimeOfDay? time;
  final BuildContext context;

  void initializeCheckOut() {
    chooseDelivery();
  }

  void chooseDelivery() async {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Navigator.of(context).pop();
                },
                child: const Text('Cancella'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  checkUserInfo();
                },
                child: Text(
                  'Seleziona',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        }));
  }

  void checkUserInfo() {
    final info = Provider.of<UserInfoProvider>(context, listen: false);

    if (deliveryMethod == "Asporto") {
      if (info.number == "" || info.name == "") {
        MySnackBar.showMySnackBar(
            context, "Devi impostare il nome e numero di telefono");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserAccountScreen()));
        return;
      }
    } else {
      if (info.number == "" || info.address == "" || info.name == "") {
        MySnackBar.showMySnackBar(context,
            "Devi impostare il nome, il numero di telefono e l'indirizzo");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserAccountScreen()));
        return;
      }
    }

    chooseTime();
  }

  void chooseTime() async {
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
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: childWidget!);
        });

    if (time != null) {
      confirmOrder();
    }
  }

  void confirmOrder() async {
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              "Il tuo orario",
              style: Theme.of(context).textTheme.bodyLarge,
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
                  Provider.of<CartItemsProvider>(context, listen: false)
                      .deliveryMethod = deliveryMethod;
                  Navigator.of(context).pop();

                  submitOrder(
                    context,
                    timeInterval: time!.to24hours(),
                    order:
                        Provider.of<CartItemsProvider>(context, listen: false),
                  );

                  showInfo();
                },
                child: Text(
                  'Ordina',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        });
  }

  void showInfo() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Ordine inviato!"),
            content: const Text(
              'Il tuo ordine è stato inviato, verrà presto confermato dalla pizzeria',
              style: TextStyle(fontSize: 16),
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

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hr = hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hr:$min";
  }
}
