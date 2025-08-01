import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Cart provider using StateNotifier to manage a list of product IDs in the cart
final cartProvider = StateNotifierProvider<CartNotifier, List<int>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<int>> {
  CartNotifier() : super([]);

  /// Add a product to the cart
  void addItem(int productId) {
    // Add duplicates: true (current behavior)
    // To prevent duplicates, uncomment the following:
    // if (!state.contains(productId)) {
    //   state = [...state, productId];
    // }

    state = [...state, productId];
  }

  /// Remove a specific product from the cart
  void removeItem(int productId) {
    state = state.where((id) => id != productId).toList();
  }

  /// Clear all items from the cart
  void clearCart() {
    state = [];
  }

  /// Get number of items in the cart
  int get itemCount => state.length;

  /// Check if a specific item is in the cart
  bool isInCart(int productId) => state.contains(productId);
}
