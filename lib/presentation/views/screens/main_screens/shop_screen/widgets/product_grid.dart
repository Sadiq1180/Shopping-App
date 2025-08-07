import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_card.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final bool isWishlistScreen;

  const ProductGrid({
    super.key,
    required this.products,
    required this.isWishlistScreen,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          image: Image.network(
            product.image,
            fit: BoxFit.contain,
            height: 100,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
          productName: product.name,
          price: product.price.toInt(),
          isCartHighlighted: product.isCartHighlighted,
          isWishlistScreen: isWishlistScreen,
          onAddToCart: product.onAddToCart,
          onDecreaseCart: product.onDecreaseCart,
          onTap: product.onTap,
          // product: product,
        );
      },
    );
  }
}
