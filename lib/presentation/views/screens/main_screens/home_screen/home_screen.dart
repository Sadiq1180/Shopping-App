import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/domain/api_models/products_model.dart';
import 'package:shopping_app/presentation/base_widgets/base_widget.dart';
import 'package:shopping_app/presentation/base_widgets/keyboard_aware.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/banner.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_card.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/search_field.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/section_header.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/title_with_button.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/shared/constants/app_assets.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    ref.read(productsProvider.notifier).getProducts();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> recommendedProducts = [
      Product(
        image: AppAssets.product6,
        name: "Rick Owens",
        price: 450,
        isCartHighlighted: true,
      ),
      Product(
        image: AppAssets.product2,
        name: "Maison Margiela",
        price: 62,
        isCartHighlighted: true,
      ),
      Product(image: AppAssets.product3, name: "Dries Van Noten", price: 500),
    ];

    return Scaffold(
      appBar: const SSenseHeader(),
      body: KeyboardAware(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BaseWidget(
              state: ref.watch(
                productsProvider.select((value) => value.productRes!),
              ),

              builder: (context) {
                final products =
                    ref.watch(productsProvider).productRes!.data
                        as ProductsModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.spaceY,

                    /// Search field
                    const CustomSearchField(
                      trailing: Icon(Icons.search),
                      searchButtonColor: Colors.amber,
                      showSearchButton: true,
                    ),
                    10.spaceY,

                    /// Banner
                    const PromotionalBanner(),
                    10.spaceY,

                    /// Title
                    TitleWithOptionalButton(
                      title: products.products!.first.brand.toString(),
                    ),
                    10.spaceY,

                    /// Horizontal Product List
                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendedProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          final product = recommendedProducts[index];
                          return ProductCard(
                            image: product.image,
                            productName: product.name,
                            price: product.price.toInt(),
                            // isCartHighlighted: true,
                            isCartHighlighted: product.isCartHighlighted,
                          );
                        },
                      ),
                    ),
                    10.spaceY,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
