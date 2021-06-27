import 'package:flutter/material.dart';

class IncreaseDecreaseButton extends StatelessWidget {
  final int incrementDecrement = 1;

  const IncreaseDecreaseButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 40,
        width: 80,
        color: Colors.amber,
        child: Row(
          children: [
            Icon(Icons.add),
            VerticalDivider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Icon(Icons.minimize),
            )
          ],
        ),
      ),
    );
  }
}
