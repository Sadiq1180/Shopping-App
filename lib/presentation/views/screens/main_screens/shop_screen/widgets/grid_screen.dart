import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/category_tab.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/product_grid.dart';
import 'package:shopping_app/shared/constants/app_assets.dart';

class ProductGridScreen extends StatefulWidget {
  const ProductGridScreen({super.key});

  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  int selectedCategoryIndex = 0;

  final List<String> categories = [
    'Menswear',
    'Womenswear',
    'Everything',
    'Accessories',
  ];

  final List<Product> allProducts = [
    Product(name: 'Nike Shoes', price: 580, image: AppAssets.product3),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTabs(
          categories: categories,
          selectedIndex: selectedCategoryIndex,
          onCategorySelected: (index) {
            setState(() => selectedCategoryIndex = index);
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ProductGrid(products: allProducts, isWishlistScreen: false),
        ),
      ],
    );
  }
}
