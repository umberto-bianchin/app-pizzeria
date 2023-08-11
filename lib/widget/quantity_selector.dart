import 'package:flutter/material.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;

  final ValueChanged<int> onChanged;

  const NumericStepButton(
      {super.key, this.minValue = 1, required this.onChanged});

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Quantità",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove,
                color: Colors.red,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              iconSize: 25.0,
              onPressed: () {
                setState(() {
                  if (counter > widget.minValue) {
                    counter--;
                  }
                  widget.onChanged(counter);
                });
              },
            ),
            Text(
              '$counter',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.green,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              iconSize: 25.0,
              onPressed: () {
                setState(() {
                  counter++;
                  widget.onChanged(counter);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
