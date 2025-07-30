import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_card.dart'; // Make sure path is correct
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Widget Function(Product)? bottomContentBuilder;

  const ProductGrid({
    super.key,
    required this.products,
    this.bottomContentBuilder,
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
          image: product.image,
          productName: product.name,
          price: product.price.toInt(),
          isCartHighlighted: product.isCartHighlighted,
          onAddToCart: () {},
          onTap: () {},
          bottomContent: bottomContentBuilder != null
              ? bottomContentBuilder!(product)
              : null,
        );
      },
    );
  }
}
