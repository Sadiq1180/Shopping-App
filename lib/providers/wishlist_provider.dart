import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/views/screens/main_screens/home_screen/widgets/product_class.dart';

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
  (ref) => WishlistNotifier(),
);

class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);

  void toggleWishlist(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p != product).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isInWishlist(Product product) {
    return state.contains(product);
  }
}
