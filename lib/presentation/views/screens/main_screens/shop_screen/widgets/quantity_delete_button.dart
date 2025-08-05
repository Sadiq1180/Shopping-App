import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/shared/app_snack_bar.dart';

class QuantityAndDeleteButton extends StatelessWidget {
  const QuantityAndDeleteButton({
    super.key,
    required this.product,
    required this.ref,
    required this.quantity,
  });

  final dynamic product;
  final WidgetRef ref;
  final dynamic quantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Remove Item'),
                content: Text(
                  'Are you sure you want to remove ${product.title} from the cart?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).removeItem(product.id);
                      Navigator.of(ctx).pop();
                      AppSnackBar.showSnackBar(
                        '${product.title} removed from cart',
                        context: context,
                      );
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Text(
          'Qty: $quantity',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
