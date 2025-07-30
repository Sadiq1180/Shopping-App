import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/base_widgets/keyboard_aware.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/notification_icon.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/search_field.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/product_grid.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';
import 'package:shopping_app/shared/shared.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = "wishlist_screen";

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> allProducts = [
      Product(
        name: 'Nike Shoes',
        price: 580,
        image: AppAssets.product3,
        reviewCount: 780,
        rating: 4.5,
      ),
      Product(name: 'Shill Shoes', price: 280, image: AppAssets.product6),
      Product(name: 'Casual Shoes', price: 350, image: AppAssets.product4),
      Product(name: 'Denim Jacket', price: 420, image: AppAssets.dress2),
      Product(
        name: 'Summer Dress',
        price: 190,
        image: AppAssets.product5,
        isFavorite: true,
        isCartHighlighted: true,
      ),
    ];

    return Scaffold(
      body: KeyboardAware(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                // Search bar and notification icon
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        hintText: "Search wishlist...",
                        showSearchButton: true,
                        onTrailingTap: () {},
                      ),
                    ),
                    5.spaceX,
                    NotificationIcon(icon: Icons.tune, notificationCount: 0),
                  ],
                ),
                10.spaceY,

                // Product Grid taking remaining space
                Expanded(
                  child: ProductGrid(
                    products: allProducts,
                    bottomContentBuilder: (product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.star, size: 16, color: Colors.orange),
                              SizedBox(width: 4),
                              Text("4.5 (235)", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
