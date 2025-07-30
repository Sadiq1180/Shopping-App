import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/base_widgets/keyboard_aware.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/notification_icon.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/search_field.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/widgets/grid_screen.dart';
import 'package:shopping_app/shared/shared.dart';

class ShopScreen extends StatelessWidget {
  static const String routeName = "shop_screen";
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: KeyboardAware(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    const NotificationIcon(icon: Icons.shopping_cart),
                  ],
                ),
                10.spaceY,
                const Expanded(child: ProductGridScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
