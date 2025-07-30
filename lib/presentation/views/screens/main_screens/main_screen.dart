import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/home_screen.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/shop_screen.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/wishlist_screen/wishlist_screen.dart';
import 'package:shopping_app/presentation/widgets/custom_bottom_navigation.dart';

import '../../../../providers/main_provider.dart';
import '../../../../shared/shared.dart';

class MainScreen extends ConsumerStatefulWidget {
  static const String routeName = "main_screen";

  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    ShopScreen(),
    WishlistScreen(),
    Center(child: Text("char screen")),
    Center(child: Text("profile screen")),
  ];

  @override
  void initState() {
    onWidgetDidBuild(() {
      ref.read(mainProvider.notifier).changeTab(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(ref.watch(mainProvider).currentIndex!),
      bottomNavigationBar: CustomBottomNavigation(
        onTap: (index) => ref.read(mainProvider.notifier).changeTab(index),
        currentIndex: ref.watch(mainProvider).currentIndex!,
      ),
    );
  }
}
