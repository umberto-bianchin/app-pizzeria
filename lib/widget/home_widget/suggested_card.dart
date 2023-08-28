import 'package:flutter/material.dart';
import '../../data/data_item.dart';
import '../item_cart_add.dart';

class SuggestedCard extends StatelessWidget {
  const SuggestedCard(this.item, {super.key});

  final DataItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8, right: 4),
      child: Card(
        elevation: 5,
        surfaceTintColor: const Color.fromARGB(255, 228, 228, 228),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(item.image),
                  height: 80.0,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "€${item.calculatePrice(context).toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return ItemCart(dataItem: item);
                });
          },
        ),
      ),
    );
  }
}
