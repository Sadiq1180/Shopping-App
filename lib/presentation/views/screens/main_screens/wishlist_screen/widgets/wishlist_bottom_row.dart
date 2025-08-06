import 'package:flutter/material.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';

class WishListScreenBottomContent extends StatelessWidget {
  const WishListScreenBottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.star, size: 16, color: Colors.orange),
            4.spaceX,
            Text("4.5 (235)", style: TextStyle(fontSize: 12)),
          ],
        ),
        const Text(
          "\$200",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
