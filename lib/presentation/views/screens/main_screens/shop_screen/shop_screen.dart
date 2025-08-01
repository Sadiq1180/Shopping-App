import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/domain/api_models/products_model.dart';
import 'package:shopping_app/presentation/base_widgets/base_widget.dart';
import 'package:shopping_app/presentation/base_widgets/keyboard_aware.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/cart_items_screen.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/notification_icon.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/search_field.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/product_grid.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/shared/shared.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';
import 'package:shopping_app/providers/cart_provider.dart'; // ✅ Add this

class ShopScreen extends ConsumerStatefulWidget {
  static const String routeName = "shop_screen";
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(productsProvider.notifier).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardAware(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Search bar & cart icon
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        hintText: "Search",
                        controller: searchController,
                        trailing: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                                width: 20,
                              ),
                              Icon(Icons.tune),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.spaceX,
                    NotificationIcon(
                      icon: Icons.shopping_cart,
                      notificationCount: ref
                          .watch(cartProvider)
                          .length, // 💡 live count here
                      onTap: () {
                        Navigation.pushNamed(CartScreen.routeName);
                      },
                    ),
                  ],
                ),
                10.spaceY,

                /// Product Grid from API
                Expanded(
                  child: BaseWidget(
                    state: ref.watch(
                      productsProvider.select((value) => value.productRes!),
                    ),
                    builder: (_) {
                      final products =
                          ref.watch(productsProvider).productRes!.data
                              as ProductsModel;
                      return ProductGrid(
                        products: products.products!
                            .map(
                              (e) => Product(
                                image: e.thumbnail ?? '',
                                name: e.title ?? '',
                                price: e.price?.toDouble() ?? 0.0,
                                isCartHighlighted: false,
                                onAddToCart: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .addItem(e.id!);
                                },
                              ),
                            )
                            .toList(),
                        isWishlistScreen: false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
