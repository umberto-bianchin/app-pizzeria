import 'package:app_pizzeria/providers/page_provider.dart';
import 'package:app_pizzeria/providers/user_infos_provider.dart';
import 'package:app_pizzeria/widget/cart_widget/order_dialogs.dart';
import 'package:app_pizzeria/widget/user_widget/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemsProvider>(context);

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
                ? (cart.confirmed
                    ? 'Totale da pagare €${cart.orderTotalPrice}'
                    : 'Differenza: €${cart.difference(context).toStringAsFixed(2)}')
                : 'Totale:  €${cart.getTotal(context).toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!cart.confirmed &&
              ((cart.cartList.isNotEmpty && !cart.ordered) || cart.modified))
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
                if (!Provider.of<UserInfoProvider>(context, listen: false)
                    .isLoggedin) {
                  MySnackBar.showMySnackBar(
                      context, "Devi essere registrato per ordinare");
                  Provider.of<PageProvider>(context, listen: false)
                      .changePage(3);
                  return;
                }

                OrderDialogs(
                  context: context,
                ).initializeCheckOut();
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
