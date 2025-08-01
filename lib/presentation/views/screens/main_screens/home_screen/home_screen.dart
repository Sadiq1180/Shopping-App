import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/domain/api_models/products_model.dart';
import 'package:shopping_app/presentation/base_widgets/base_widget.dart';
import 'package:shopping_app/presentation/base_widgets/keyboard_aware.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/banner.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_card.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/search_field.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/section_header.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/title_with_button.dart';
import 'package:shopping_app/providers/products_provider.dart';
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
    super.initState();
    ref.read(productsProvider.notifier).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productsProvider);

    return Scaffold(
      appBar: const SSenseHeader(),
      body: KeyboardAware(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BaseWidget(
              state: productState.productRes!,
              builder: (context) {
                final products = productState.productRes!.data as ProductsModel;
                final recommendedProducts = products.products!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSearchField(
                      trailing: Icon(Icons.search),
                      searchButtonColor: Colors.amber,
                      showSearchButton: true,
                    ),
                    10.spaceY,
                    const PromotionalBanner(),
                    10.spaceY,

                    TitleWithOptionalButton(title: "Recommended Styles"),
                    10.spaceY,

                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendedProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          final product = recommendedProducts[index];
                          return ProductCard(
                            image: Image.network(
                              product.thumbnail ?? '',
                              fit: BoxFit.contain,
                              height: 100,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.broken_image),
                            ),
                            productName: product.title ?? '',
                            price: product.price?.toInt() ?? 0,
                            isCartHighlighted: false,
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
