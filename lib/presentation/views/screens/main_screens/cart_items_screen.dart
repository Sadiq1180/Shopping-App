import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/quantity_delete_button.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/total_amount_section.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/shared/app_persistance/app_local.dart';
import 'package:shopping_app/shared/constants/app_local_keys.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';
import 'package:shopping_app/domain/api_models/products_model.dart';

class CartScreen extends ConsumerStatefulWidget {
  static const String routeName = "cart_screen";

  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  // dynamic productList;
  List<dynamic> productList = [];

  @override
  void initState() {
    super.initState();
    // productList = AppLocal.ins.cartBox.clear();
    getList();
  }

  void getList() {
    final list = AppLocal.ins.cartBox.get(AppLocalKeys.product);
    if (list != null && list is List) {
      setState(() {
        productList = list;
      });

      if (productList.isNotEmpty) {
        print('nameeee ${productList[0]['name']}');
        print('quantityyyy: ${productList.length}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);

    final productsModel =
        ref.watch(productsProvider).productRes?.data as ProductsModel?;

    final allProducts = productsModel?.products ?? [];

    // // Combine cart items with product info
    final itemsInCart = cartItems
        .map((cartItem) {
          try {
            final product = allProducts.firstWhere((p) => p.id == cartItem.id);
            return {'product': product, 'quantity': cartItem.quantity};
          } catch (e) {
            return null;
          }
        })
        .whereType<Map<String, dynamic>>()
        .toList();

    // // Calculate total price
    final totalPrice = itemsInCart.fold<double>(
      0,
      (sum, item) =>
          sum + ((item['product']?.price ?? 0) * (item['quantity'] ?? 1)),
    );

    // final recentProducts = AppLocal.ins.dataBox.get(AppLocalKeys.product);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart"), centerTitle: true),
      body: Column(
        children: [
          //  Top area
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text("No items in cart"))
                : ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: itemsInCart.length,
                    separatorBuilder: (_, __) => 10.spaceY,
                    itemBuilder: (context, index) {
                      final item = itemsInCart[index];
                      final product = item['product'];
                      final quantity = item['quantity'];

                      return Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          right: 15,
                        ),
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
                                    '${product.title}',
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

                            // Quantity and delete button
                            QuantityAndDeleteButton(
                              product: product,
                              ref: ref,
                              quantity: quantity,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          /////-----------Button just for testing ---------------/////////////
          // TextButton(
          //   onPressed: () async {
          //     final cartBox = await Hive.openBox('cartBox');
          //     if (cartBox.isNotEmpty) {
          //       ref.read(cartProvider.notifier).clearCart();
          //       print(
          //         'Cart was cleared. First product name: ${productList[0]['name']}',
          //       );
          //     } else {
          //       print('Cart is already empty.');
          //     }
          //   },
          //   child: Text("Clear Hive Box"),
          // ),

          //  Bottom Total section
          TotalAmountSection(totalPrice: totalPrice),
        ],
      ),
    );
  }
}
