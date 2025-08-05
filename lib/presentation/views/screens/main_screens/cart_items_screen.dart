import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/total_amount_section.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/shared/app_persistance/app_local.dart';
import 'package:shopping_app/shared/app_snack_bar.dart';
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
        print('nameeee ${productList.length}');
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
          // 👇 Top area (cart items or empty message)
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text("No items in cart"))
                : ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemCount: itemsInCart.length,
                    separatorBuilder: (_, __) => 10.spaceY,
                    itemBuilder: (context, index) {
                      final item = itemsInCart[index];
                      final product = item['product'];
                      final quantity = item['quantity'];

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

          //  Bottom Total section
          TotalAmountSection(totalPrice: totalPrice),
        ],
      ),
    );
  }
}

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
