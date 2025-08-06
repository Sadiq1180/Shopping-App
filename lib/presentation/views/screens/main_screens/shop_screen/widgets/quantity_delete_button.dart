import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/shared/app_snack_bar.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';

class QuantityAndDeleteButton extends StatefulWidget {
  const QuantityAndDeleteButton({
    super.key,
    required this.product,
    required this.ref,
    required this.quantity,
    this.onDecreaseCart,
  });

  final dynamic product;
  final WidgetRef ref;
  final dynamic quantity;
  final VoidCallback? onDecreaseCart;

  @override
  State<QuantityAndDeleteButton> createState() =>
      _QuantityAndDeleteButtonState();
}

class _QuantityAndDeleteButtonState extends State<QuantityAndDeleteButton> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ---- Buttons Row ---- //
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.quantity > 1) {
                  setState(() {
                    quantity--;
                    widget.onDecreaseCart?.call();
                  });
                  widget.ref
                      .read(cartProvider.notifier)
                      .decreaseItem(widget.product.id);
                } else {}
              },
              child: const Icon(
                Icons.remove,
                size: 20,
                color: Colors.redAccent,
              ),
            ),

            12.spaceX,
            Text(
              '${widget.quantity}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            12.spaceX,
            GestureDetector(
              onTap: () {
                widget.ref
                    .read(cartProvider.notifier)
                    .addItem(widget.product.id);
              },
              child: const Icon(Icons.add, size: 20, color: Colors.green),
            ),
          ],
        ),

        // ---- Delete Button with Confirmation ---- //
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Remove Item'),
                content: Text(
                  'Are you sure you want to remove ${widget.product.title} from the cart?',
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
                      widget.ref
                          .read(cartProvider.notifier)
                          .removeItem(widget.product.id);
                      Navigator.of(ctx).pop();
                      AppSnackBar.showSnackBar(
                        '${widget.product.title} removed from cart',
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

        // ---- Quantity Label ---- //
        Text(
          'Qty: ${widget.quantity}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
