import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';
import 'package:shopping_app/domain/api_models/products_model.dart';

class CartScreen extends ConsumerWidget {
  static const String routeName = "cart_screen";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemIds = ref.watch(cartProvider);
    final productsModel =
        ref.watch(productsProvider).productRes?.data as ProductsModel?;

    // Show only items that are in the cart
    final cartItems = productsModel?.products
        ?.where((product) => cartItemIds.contains(product.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart"), centerTitle: true),
      body: cartItems == null || cartItems.isEmpty
          ? const Center(child: Text("No items in cart"))
          : ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => 10.spaceY,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        product.thumbnail ?? '',
                        height: 60,
                        width: 60,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                      10.spaceX,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            4.spaceY,
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
