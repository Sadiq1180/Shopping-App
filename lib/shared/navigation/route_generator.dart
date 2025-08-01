import 'package:go_router/go_router.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/cart_items_screen.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/shop_screen/shop_screen.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/wishlist_screen/wishlist_screen.dart';
import '../../main.dart';
import '../../presentation/views/dummy_screen.dart';
import '../../presentation/views/screens/main_screens/main_screen.dart';
import '../shared.dart';

final router = GoRouter(
  //  initialLocation: '/${MainScreen.routeName}',
  initialLocation: '/',
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      name: TopScreen.routeName,
      path: '/',
      builder: (context, state) => const TopScreen(),
    ),
    GoRoute(
      name: DummyScreen.routeName,
      path: '/${DummyScreen.routeName}',
      builder: (context, state) => const DummyScreen(),
    ),

    /// ADDED SCREEN FOR SHOPPING APP
    GoRoute(
      name: MainScreen.routeName,
      path: '/${MainScreen.routeName}',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      name: ShopScreen.routeName,
      path: '/${ShopScreen.routeName}',
      builder: (context, state) => const ShopScreen(),
    ),
    GoRoute(
      name: WishlistScreen.routeName,
      path: '/${WishlistScreen.routeName}',
      builder: (context, state) => const WishlistScreen(),
    ),
    GoRoute(
      name: CartScreen.routeName,
      path: '/${CartScreen.routeName}',
      builder: (context, state) => const CartScreen(),
    ),
  ],
);

// class RouteGenerator {
//   static Route generateRoute(RouteSettings settings) => switch (settings.name) {
//         MyScreen.routeName => route(MyScreen()),
//         DummyLessScreen.routeName => route(const DummyLessScreen()),
//         DummyScreen.routeName =>
//           route(DummyScreen(params: settings.arguments as DummyScreenArgs?)),
//         _ => route(const ErrorRoute()),
//       };
// }

// Route route(Widget screen) => MaterialPageRoute(builder: (context) => screen);

// class ErrorRoute extends StatelessWidget {
//   const ErrorRoute({super.key});

//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('You should not be here...')));
// }
