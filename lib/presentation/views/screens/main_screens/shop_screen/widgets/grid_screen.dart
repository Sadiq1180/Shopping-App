// product_grid_screen.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/product_grid.dart';

class ProductGridScreen extends StatefulWidget {
  final List<Product> products;

  const ProductGridScreen({super.key, required this.products});

  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ProductGrid(
            products: widget.products,
            isWishlistScreen: false,
          ),
        ),
      ],
    );
  }
}
